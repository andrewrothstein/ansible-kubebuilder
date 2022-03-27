#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/kubernetes-sigs/kubebuilder/releases/download
APP=kubebuilder

dl()
{
    local ver=$1
    local lchecksums=$2
    local os=$3
    local arch=$4
    local platform="${os}_${arch}"
    local file=${APP}_${platform}
    local url=$MIRROR/v$ver/$file
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(fgrep $file $lchecksums | awk '{print $1}')
}

dl_ver()
{
    local ver=$1
    local lchecksums=$DIR/${APP}_${ver}_checksums.txt
    local rchecksums=$MIRROR/v$ver/checksums.txt
    if [ ! -e $lchecksums ];
    then
        curl -sSLf -o $lchecksums $rchecksums
    fi

    printf "  # %s\n" $rchecksums
    printf "  '%s':\n" $ver

    dl $ver $lchecksums darwin amd64
    dl $ver $lchecksums linux amd64
    dl $ver $lchecksums linux arm64
    dl $ver $lchecksums linux ppc64le
}

dl_ver ${1:-3.3.0}
