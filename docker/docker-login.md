# Docker Login

`docker login` assumes that `docker-credential-desktop` is in the path. `docker-credential-desktop` is installed by Docker desktop. Docker Desktop is hot garbage. To use with docker machine

```c
brew install docker-credentials-helper
ln -s (which docker-credential-osxkeychain) ~/.local/bin/docker-credential-desktop # or another path dir
```

