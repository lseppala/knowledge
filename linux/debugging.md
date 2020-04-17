# Debugging in Linux

Core files are written to files using a template in
/proc/sys/kernel/core_pattern. Cat the file

`ulimit` may be unset. Use `ulimit -c unlimited` to set no limit in core dump
size

`gcore` to generate a core file of running process
