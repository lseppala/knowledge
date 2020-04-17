# GNU Make

GNU (and BSD-relatives) Make is a simple build tool. While an older tool, I have
found it to be a really effective tool in all but the most unique cases.

Make is configured with a `Makefile`, a file that is half shell-script, half
declarative-programming model.

## Makefiles

## Variables

Variables are declared with the one of a few "flavors":

```bash

# Simple variable.
SIMPLE_VAR := value
SIMPLE_VAR := anonther $(SIMPLE_VAR_NAME)

# lazy variable or 'recursively expanded' variable, won't be executed until
# needed. Can cause an infinite loop if self-references
LAZY_VAR = value
# don't do this
LAZY_VAR = $(LAZY_VAR)


# Conditional variable. Will use the value provided if another variable does
# not exist. Useful for overriding with the environment variables with same
# name
CONDITIONAL_VAR ?= value
```

Variable names are not required to be all-caps, but it is traditional. Spaces
around the assingment operator are optional.

To reference a variable in the makefile, use the syntax `$(VARIABLE)` or
`${VARIABLE}`. They are equivalent.

Variables are simply expanded as text in the makefile. For example:

```bash
ECH = ech
O = o

BAD_PLACE = hell

hello:
	$(ECH)$(O) $(BAD_PLACE)$(O)!
```

`make hello` will produce the command `echo hello!` and print `hello!`.

### Prefixes

If a command is prefixed with `@`, the command is not echoed to the shell during
execution. This is typically the preferred model.

With the prefix `-`, the command will succeed even if the shell execution
returns with a non-zero exit code. This should be rarely used.

The prefix `+` causes the command to always be executed, even if make is invoked
with `-n/--dry-run/--just-print`, `-t/--touch`, or `-q/--question`.
