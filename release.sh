#!/usr/bin/env bash

version="$1"

if git tag | grep -q "^${version}$"; then
  echo "Tag for version ${version} already exists"
  exit 1
fi

if [[ -n $(git status --porcelain) ]]; then
  echo "Git workspace is not empty, aborting..."
  exit 1
fi

if ! [[ "${version}" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Invalid version ${version}"
  exit 1
fi

major_version=$(echo "${version:1}" | cut -d. -f1)
minor_version=$(echo "${version:1}" | cut -d. -f2)

git tag "${version}" # specific version tag
git tag -f "v${major_version}" # major version tag
git tag -f "v${major_version}.${minor_version}" # minor version tag
git push -f --tags
