# A Conversation with Go Modules

## Introduction

Go! I hear you finally an officially-supported dependency management system!
Built right in, no external tools with spotty support.

> Yup! They're called Go Modules, and after nearly 7 (!) years of mucking around
> in your file system with a magic path and environment variables, we've got
> something you'll really like!

That's great! Because, well... I hate to say this, but I've been _really_
hesitant to use you because of your dependency management. It's been a huge turn
off.

> Why's that?

It seemed like a really fragile way to specify and management dependencies. All
systems become legacy systems after time, and managing dependency versions is
crucial. And when new people leaving the team, it seemed like it could be a real
headache to make sure everyone has identical build environments.

> That's why you should use Docker! Docker docker docker! The only reason to
> have a personal computer is to have a place to run Docker!

Enough of that. How do I get started?

> Run `go mod init` in your repo!

Uh. I've got the error,

`cannot determine module path for source directory, go-mad (outside GOPATH, module path must be specified)`

I thought this was moving us past the GOPATH stuff?

> Nope, it's still there! Try `go mod init github.com/username/projectname`
> Guess you'll need to think of where this repo will live publicly before you
> even care!

That raises another thing I've never been a fan of in Go packaging. If I specify
my module path as `github.com/username/projectname`, then it makes it really
annoying for other people to fork and contribute back to my project. I think
that's a contributing factor to why so many public Go libraries are in a state
of 70% completion before they're abandoned. Is there a better way?

> Well, you _can_ name the module using a single name without the path with `go
> mod init projectname, but there's no real indication whether this is even
> supported! Will it cause issues when people try to import your project?
> Probably!

Something to worry about later, I suppose... oh! This is looking better. I've
got a `go.mod` file! Is that where I specify dependencies?

> It sure is!

## Installing dependencies

How do I add a dependency? I don't even know the format this should be in.

> Use `go get`

Wait. That's the same `go get` that I've been using to install packages into my
GOPATH?

> That's the one!

Okay. That feels like it confuses the semantics. I'm used to `go get` installing
dependencies into GOPATH, but now it installs it with Go Modules?

> It still installs into the GOPATH, but now it installs the source into
> `$GOPATH/pkg/mod/package-name@version`

Oh, wonderful! There's versions now. How do I install a specific version?

> `go get path/package-name@version`

I like that, that's great!

> Happy to hear! But you can't use that outside a directory with an initialized
> module, or it will fail.

Sorry, what?

> If you use `go get path/package-name@version` outside of a directory with a
> `go.mod`, you will get the error
> `go: cannot use path@version syntax in GOPATH mode`

... do you get what I mean about confusing the semantics of `go get`? I can use
the same command in different directories and it produces completely different
results.

> Sounds like a personal problem.

Can I specify the versions of tools installed with `go get`? I might not want to
install a newer version of a tool I use.

> Nope! Everyone one should always use the cutting edge, even if it's broken!

## `go.mod` and `go.sum`

What is the `go.sum` file?

> This is where all of your dependencies and version are specified. If something
> is commented with `indirect`, it's a transitive dependency or something you
> installed with `go get`. One or the other, you figure it out.

Okay, how do I maintain this file?

> I'll clean out any dependency marked 'indirect' that's not a transitive
> dependency or imported in your source code when you run `go mod tidy`

Wait, the package I installed with `go get` earlier is indirect, how do I make
it direct so it's not cleared out when I run `go mod tidy`?

> Import it in your source code and I'll remove the comment. Also, you didn't
> need to get to use `go get`—if you import a dependency in your source code,
> I'll automatically add it to the `go.mod` file when you run `go build`.

I don't think you should be modifying the dependency file when I'm compiling the
source code. Those seem like a completely separate responsibility and an
unintended side-effect.

> I also do the same with `go test`!

Oh boy, that sounds like it might bite me later. What's this `go.sum` file? Is
this like a version lock-file that I'm used to from other languages?

> Hahahah! You silly goose, of course not! It's a file of cryptographic hashes
> of the dependencies you've installed. It's to make sure the dependency you
> rely on isn't compromised and replaced with a malicious version.

Oh, that's a good thing. How do I update it?

> I'll update it whenever you add new dependencies or run `go mod tidy`...

Okay

> or sometimes when you run `go build` or `go test`, even though the
> dependencies haven't changed.

...what. Why?

> No idea, but it'll cause your CI build to break if you have `-mod=readonly`
> set like you are suggested to use in the documentation. I'll try to update
> go.sum when running tests and fail with an error.

Fine. But if a library I depend on gets compromised, will I get a cryptic error
message or will you tell me about the danger I'm in?

> Oh, cryptic error message, 100%

Right, so I and everyone else are definitely going to ignore that error and
think it's `go.sum` acting up, delete the file, and rebuild it with the hash
from the malicious dependency. Thanks for less than nothing.

> You're welcome bub!

## Installing development dependencies, build tools

Okay, I need some tools to help with building my code, like `goimports`. How do
I install them?

> `go get`, of course!

Won't this add the tool to my `go.mod` file and then be taken out later?

> Definitely.

So how do I declare it so my teammates can use the same dependency and version
I'm using?

> The most brilliant minds Go has to offer has come up with this amazing
> solution. Create a `tools.go` file that looks like this!

```go
// +build tools

package tools

import (
    _ "golang.org/x/tools/cmd/goimports"
    _ "honnef.co/go/tools/cmd/staticcheck"
    )

```

> this file will add the dependencies to go.mod file and keep `go mod tidy` from
> removing them, but won't be built because of the build-tag declared at the
> top.

This seems like a huge hack.

> No, never! It's the official recommendation with no indication to improve it!
> https://github.com/golang/go/wiki/Modules#how-can-i-track-tool-dependencies-for-a-module

Ok. I can then download and update `go.mod` by running `go build ./tools.go`. It
gives me errors that imports are a program, not an importable package, but
seemed mostly work. But where's the executable?

> You need to run `go install path/package/cmd/tool` to install it into
> `$GOPATH/bin`

Any easy way to do that?

> Write an awk script to parse out the dependencies in `tools.go` run go install
> on each!

```
awk '/_/ { print $2 }' | cut -d'"' -f2 | xargs go install
```

_Sigh_. Any other catches?

> If a dependency is marked with `+incompatible`, it means it both 1) does not
> have a go.mod file and 2) is tagged as a v2 or above version (we give more
> leeway to v1 and v0 for Reasons™). Also, this means the above technique _does
> not even work_ with "incompatible" dependencies.

So what should I do for those many, many tools?

> Disable Go modules and use the old GOPATH method to install an arbitrary,
> untracked version! `GO111MODULES=off go get <package>`

... I can't even.

## Help and Documentation

Where do I get more information and help about go modules?

> You can run `go help modules` to read the really dense, jargon-filled help
> text included with Go. Remember to pipe it into a pager like `less`, because
> there's no other command that puts its help messages in a pager in a
> user-friendly way (https://github.com/golang/go/issues/14336)

What about `man`?

> That doesn't count.

`perldoc`?

> What's that?

`npm help <command>`?

> Never heard of it.

Never mind. This documentation is... really hard to understand, and I'm a
reasonably intelligent person who's used a lot of different dependency
management solutions. Is there anything else?

> Besides a bunch of Medium posts with conflicting advice, you can always read
> the official Github wiki! https://github.com/golang/go/wiki/Modules
>
> Because when you think of "authoritative source", you typically look for
> Github wikis!

## Vendoring

> You can also vendor all of your dependencies with `go mod vendor`. This adds
> all of the source code to your local directory, which can be checked in. Even
> though the Go team spend years railing against this practice during the time
> of GOPATH, they built it right in!

> make sure you have at least one non-indirect dependency specified in your
> go.mod file before running `go mod vendor`, or you'll get this seemingly
> irrelevant error:

`go mod vendor: open /Users/$SOME_PATH/vendor/modules.txt: no such file or directory`
