# cross-clang
repository to publish binaries of clang cross compile wrappers for MSYS2.  Maybe at some point the packages could be built here in GHA.  For now, the source of these is msys2/MINGW-packages#8762, the CI checks on that PR, and a similar CI run on CLANGARM64 for the `mingw-w64-clang-aarch64-*` packages.

## Usage
The files are in the release https://github.com/msys2-arm/cross-clang/releases/download/repo.  To use, add the following in `/etc/pacman.conf`:

```ini
[cross-clang]
Server = https://github.com/msys2-arm/cross-clang/releases/download/repo
SigLevel = Never
```
