#!/usr/bin/env sh
set -e
DIR=$(mktemp -d)
trap 'rm -rf "$DIR"' EXIT
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
    local sum
    sum=$(awk -v f="$file" '$2 == f || $2 == "*" f {print $1}' "$lchecksums")
    if ! printf '%s' "$sum" | grep -Eq '^[0-9a-f]{64}$'
    then
        echo "bad or missing checksum for $file: '$sum'" >&2
        exit 1
    fi
    printf "    # %s\n" "$url"
    printf "    %s: sha256:%s\n" "$platform" "$sum"
}

dl_ver()
{
    local ver=$1
    local lchecksums=$DIR/${APP}_${ver}_checksums.txt
    local rchecksums=$MIRROR/v$ver/checksums.txt
    curl -fsSL --proto '=https' --tlsv1.2 -o "$lchecksums" "$rchecksums"

    printf "  # %s\n" $rchecksums
    printf "  '%s':\n" $ver

    dl $ver $lchecksums darwin amd64
    dl $ver $lchecksums darwin arm64
    dl $ver $lchecksums linux amd64
    dl $ver $lchecksums linux arm64
    dl $ver $lchecksums linux ppc64le
}

dl_ver ${1:-4.16.0}
