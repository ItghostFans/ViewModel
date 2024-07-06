#!/bin/bash

tag=$1
git tag $tag
git push origin $tag
git push origin --tags

#pod repo list

repo='cocoapods'
podName='ViewModel'
pod repo push $repo $ViewModel'.podspec'