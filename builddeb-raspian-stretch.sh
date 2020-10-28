#!/bin/bash

set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export FLAVOUR="raspbian-stretch"

( cd "$DIR" && docker build -t "builddeb-$FLAVOUR" . )

exec "$DIR/builddeb.sh" "$@"