#!/bin/bash

set -e

if [ "$#" -ne "1" ]; then
    echo "usage: $0 <version>, example: $0 3.3.6.0"
    exit -1
fi

version=$1
cat > LATEST_VERSION << EOF
$version
EOF

git commit -am "feat: upgrade to $version" && git tag "v$version" && git push && git push --tags
