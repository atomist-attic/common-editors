#!/bin/bash

set -eu
set -o pipefail

function msg() {
    echo "travis-build: $*"
}

function err() {
    msg "$*" 1>&2
}

formula=$(curl -s -f https://static.atomist.com/Formula/rug-cli.rb)
if [[ $? -ne 0 || ! $formula ]]; then
    err "failed to download brew formula: $formula"
    exit 1
fi
version=$(echo "$formula" | sed -n '/ url /s,.*/\([0-9]*\.[0-9]*\.[0-9]*\)/.*,\1,p')
if [[ $? -ne 0 || ! $version ]]; then
    err "failed to parse brew formula for version: $version"
    err "$formula"
    exit 1
fi
msg "rug CLI version: $version"
rug=$HOME/.atomist/rug-cli-$version/bin/rug
if [[ ! -x $rug ]]; then
    msg "fetching rug CLI"
    mkdir -p "$HOME/.atomist"
    curl -s -o "$HOME/.atomist/rug-cli-$version.tar.gz" "https://$ARTIFACTORY_USER:$ARTIFACTORY_PASSWORD@sforzando.artifactoryonline.com/sforzando/libs-release-local/com/atomist/rug-cli/$version/rug-cli-$version-bin.tar.gz"
    tar -xzf "$HOME/.atomist/rug-cli-$version.tar.gz" -C "$HOME/.atomist"
fi
rug="$rug -qX"

msg "running tests"
$rug test

msg "installing archive"
$rug install

archive_version=$(awk -F\" '/^version:/ { print $2 }' .atomist/manifest.yml)
if [[ $? -ne 0 || ! $archive_version ]]; then
    err "failed to extract archive version from manifest: $archive_version"
    exit 1
fi
if [[ $TRAVIS_TAG =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    if [[ $archive_version != $TRAVIS_TAG ]]; then
        err "archive version ($archive_version) does not match git tag ($TRAVIS_TAG)"
        exit 2
    fi
    project_version=$TRAVIS_TAG
else
    timestamp=$(date +%Y%m%d%H%M%S)
    if [[ $? -ne 0 || ! $timestamp ]]; then
        err "failed to generate timestamp: $timestamp"
        exit 1
    fi
    project_version=$archive_version-$timestamp
fi

msg "branch: $TRAVIS_BRANCH"
msg "archive version: $project_version"

[[ $TRAVIS_PULL_REQUEST == false ]] || exit 0
if [[ $TRAVIS_BRANCH == master || $TRAVIS_TAG =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    msg "publishing archive"
    $rug publish -a "$project_version"
    git config --global user.email "travis-ci@atomist.com"
    git config --global user.name "Travis CI"
    git_tag=$project_version+travis$TRAVIS_BUILD_NUMBER
    git tag "$git_tag" -m "Generated tag from TravisCI build $TRAVIS_BUILD_NUMBER"
    git push --tags -q "https://$GITHUB_TOKEN@github.com/$TRAVIS_REPO_SLUG"
fi

exit 0
