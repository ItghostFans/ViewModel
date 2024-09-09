#!/bin/bash

#~/.cocoapods
#pod spec edit ReactiveObjC

tag=$1
podspec=`ls *.podspec`
podName=${podspec%.*}

sed -i '' "s/\'[0-9]*\.[0-9]*\.[0-9]*.*\'/\'${tag}\'/g" "$podName.podspec"

git add *
git commit -m $tag
git push -u origin main

git tag $tag
git push origin $tag
git push origin --tags

# 前置条件
#pod repo list
#pod trunk register ItghostFans@gmail.com ItghostFans --verbose

# repo='cocoapods'
pod trunk push $podName.podspec --allow-warnings --verbose
