#!/bin/bash
#
# Pull the latest version of all the isula images used in the mini-Internet

set -o errexit
set -o pipefail
set -o nounset

for name in router ixp host ssh measurement dns switch matrix vpn vlc hostm; do
    echo isula pull thomahol/d_$name
    isula pull thomahol/d_$name
done
