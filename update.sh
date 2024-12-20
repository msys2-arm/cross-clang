#!/bin/bash

shopt -s extglob
set -e

function getsums() {
  if (( ${#source[*]} != ${#sha256sums[*]} )); then
    echo "Error: mismatched source and sha256sums array lengths" >&2
    return 2
  fi

  local idx cmake compiler_rt
  for (( idx = 0; idx < ${#source[*]}; idx++ )); do
    if [[ "${source[$idx]}" == *cmake-*.src.tar.!(*.sig) ]]; then
      cmake="${sha256sums[$idx]}"
    elif [[ "${source[$idx]}" == *compiler-rt-*.src.tar.!(*.sig) ]]; then
      compiler_rt="${sha256sums[$idx]}"
    fi
  done
  echo "${pkgver}|${compiler_rt}|${cmake}"
}

if (( $# < 1 )); then
  echo "Usage: $0 <path/to/mingw-w64-llvm/PKGBUILD" >&2
  exit 1
fi

IFS="|" read old_pkgver old_compiler_rt old_cmake < <(source mingw-w64-cross-compiler-rt/PKGBUILD && getsums)
IFS="|" read new_pkgver new_compiler_rt new_cmake < <(source "$1" && getsums)

sed -i -e "s|^pkgver=$old_pkgver|pkgver=$new_pkgver|" -e "s|'$old_compiler_rt'|'$new_compiler_rt'|" -e "s|'$old_cmake'|'$new_cmake'|" mingw-w64-cross-compiler-rt/PKGBUILD mingw-w64-cross-clang/PKGBUILD

