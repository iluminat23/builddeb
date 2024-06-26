#!/bin/bash

set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export FLAVOR="revpi64-bullseye"

( cd "${DIR}" && docker build -t "builddeb-${FLAVOR}" --pull -f "${FLAVOR}/Dockerfile" . )

exec "$DIR/builddeb.sh" "$@"
