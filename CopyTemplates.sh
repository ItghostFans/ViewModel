#!/bin/bash

xcodeTemplatePath='/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/File Templates/iOS'
mvvmTemplatePath=$xcodeTemplatePath/MVVM
echo $mvvmTemplatePath
sudo rm -rf "$mvvmTemplatePath"
sudo mkdir -p "$mvvmTemplatePath"

mvvmTemplates=(`ls Resources/Templates`)

for path in ${mvvmTemplates[@]} 
do
    # echo "Resources/Templates/${path}"
    # echo "$templatePath"
    cp -Rf "Resources/Templates/${path}" "$mvvmTemplatePath"
done
