# Debugging in Go

Go's debugging tool is [Delve](https://github.com/go-delve/delve)

`GOTRACEBACK=crash ./myprogram` to segfault and create a core dump rather than
panic in the runtime


Sources:
- https://fntlnz.wtf/post/gopostmortem/
