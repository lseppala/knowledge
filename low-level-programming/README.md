# Low-Level Programming

## MacOS (darwin) vs GNU/Linux

In Linux, the global label is `_start`. In MacOS, the global label is `start`

Syscalls numbers are different between the two, and MacOS starts syscalls
numbers at `0x2000000`. E.g, for `exit`, `mov rax, 0x2000001` on MacOS,
`mov rax, 0x1` on Linux.

To compile and link NASM on OS X:

```bash
nasm -f macho64 hello_world.asm
ld -macosx_version_min 10.7.0 -lSystem -o hello_world
./hello_world
```

or `asm`

```bash
asm -f macho64 -l exit.lst exit.asm
ld -static -o exit exit.o
```
