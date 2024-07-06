#!/bin/bash

tag=$1
git tag $tag
git push origin $tag
git push origin --tags

#pod repo list
#pod trunk register ItghostFans@gmail.com ItghostFans --verbose

# repo='cocoapods'
podName='ViewModel'
pod trunk push $podName.podspec --allow-warnings --verbose