# Go modules

Go has a complicated, unresolved history with dependency management. For
~~opinions~~ rants about this and other things, see
[Terrible Things About Go](terrible-things-in-Go.md). this line is very long
line why not format this line oh yay it does but it also breaks the url. Still,
this is preferable. Let's see if it continues to break the line it does not this
seems to be what I want.

All packages and dependencies were (and still are) stored in the GOPATH. The
GOPATH, by default `$HOME/go`

You can avoid the VCS path imports with go modules. `go mod init $name`, or
change the `module` line in go.mod file to `$name` and all source code where the
VCS to `$name/package-path`
