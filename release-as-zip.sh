#!/bin/bash

set -e

VERSION=$(cat package.json | jq --raw-output .version)
PKG_NAME=$(cat package.json | jq --raw-output .name)
GITHUB_ORGANIZATION='sphereio'
LATEST_BRANCH_NAME='latest'

echo "About to release ${PKG_NAME} - v${VERSION} to ${LATEST_BRANCH_NAME} branch!"

cleanup() {
  set +e
  echo "Cleaning up"
  rm -rf package
  rm "${PKG_NAME}"-*
  rm -rf tmp
  set -e
}

# cleanup
cleanup

# install all deps
echo "Installing all deps"
npm install &>/dev/null
echo "Building sources"
grunt build &>/dev/null

# package npm and extract it
echo "Packaging locally"
npm pack
tar -xzf "${PKG_NAME}-${VERSION}.tgz"

cd package
# install production deps (no devDeps)
echo "Installing only production deps"
npm install --production &>/dev/null
# push everything inside package to 'latest' branch
git init
git remote add origin "git@github.com:${GITHUB_ORGANIZATION}/${PKG_NAME}.git"
git add -A &>/dev/null
git commit -m "Release packaged version ${VERSION} to ${LATEST_BRANCH_NAME} branch" &>/dev/null
echo "About to push to ${LATEST_BRANCH_NAME} branch"
git push --force origin master:${LATEST_BRANCH_NAME}
cd -

# test that zipped package works
echo "About to download and test released package"
mkdir -p tmp
cd tmp
curl -s -L "https://github.com/${GITHUB_ORGANIZATION}/${PKG_NAME}/archive/latest.zip" -o latest.zip
unzip -q latest.zip
cd "${PKG_NAME}-latest"/
node lib/run
cd ../..

# cleanup package / tmp folder
cleanup

echo "Congratulations, the latest package has been successfully released"
