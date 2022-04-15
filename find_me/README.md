1、要使用命令行在 Mac 上显示隐藏文件，请执行以下步骤：
defaults write com.Apple.finder AppleShowAllFiles -bool true
killall Finder
2、一般情况下不会将pods文件夹下的文件提交到远程git库。只要将Podfile和Podfile.lock（cocoapods的第三方管理文件）两个文件提交到git进行版本管理即可。
https://blog.csdn.net/denggun12345/article/details/82182586
3、iOS .ignore

# Xcode
.DS_Store
*/build/*
*.pbxuser
!default.pbxuser
*.mode1v3
!default.mode1v3
*.mode2v3
!default.mode2v3
*.perspectivev3
!default.perspectivev3
xcuserdata
profile
*.moved-aside
DerivedData
.idea/
*.hmap
*.xccheckout
*.xcworkspace
!default.xcworkspace

#CocoaPods
Pods
!Podfile
!Podfile.lock
 