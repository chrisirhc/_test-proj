#!/bin/bash

if [ "$TRAVIS_BRANCH" == "master" ]; then
    openssl aes-256-cbc -K $encrypted_0e643f7c177c_key -iv $encrypted_0e643f7c177c_iv -in .travis/id_release.enc -out ~/.ssh/id_rsa -d
    chmod 600 ~/.ssh/id_rsa
    git clone --depth 1 git@github.com:chrisirhc/_test-proj-releases.git release
    mv build/* release/
    version=`git rev-parse --short HEAD`
    cd release/
    git add .
    git config user.name "Bot"
    git commit -m "$version (automatic)"
    git push origin master
else
    echo "Do nothing since it's not a release branch."
fi
