#!/usr/bin/env -S -- bash -Eeu -O dotglob -O nullglob -O extglob -O globstar

set -o pipefail

cd -- "${0%/*}"

LR="${1:-"left"}"

case "$OSTYPE" in
darwin*)
  VOL='/Volumes/ADV360PRO'
  ;;
*)
  set -x
  exit 1
  ;;
esac

if ! [[ -d $VOL ]]; then
  set -x
  exit 1
fi

rm -v -fr -- ./firmware/!(.gitkeep)
make
printf '' > ./config/version.dtsi

mv -v -- ./firmware/*-"$LR.uf2" "$VOL/CURRENT.UF2"
