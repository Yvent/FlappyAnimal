//
//  ZGlobal.swift
//  wave
//
//  Created by 周逸文 on 16/9/7.
//  Copyright © 2016年 com.paohaile.zyw. All rights reserved.
//全局配置文件

import Foundation
import UIKit


//MARK: UI
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

var LevelCount: Int = 10

func AdaptationHeight(_ height: CGFloat) -> CGFloat {
    
    return CGFloat(ScreenHeight/667) * height
}
func AdaptationWidth(_ width: CGFloat) -> CGFloat {
    return CGFloat(ScreenWidth/375) * width
}

func AdaptationFontSize(_ size: CGFloat) -> CGFloat {
    return CGFloat(ScreenHeight/667) * size
}
func newSubviews<T: UIView>(_ oldViews: Array<UIView>,newClass: T.Type) -> Array<T>{
    var newArray: Array<T> = Array<T>()
    for item in oldViews {
    
        if item.isKind(of: newClass) {
            newArray.append(item as! T)
        }
    }
    return newArray
}
//debug
func DebugPrint<T>(_ message: T) {
    print(message)
}

func RGBSingle(_ s: CGFloat) -> UIColor {
    return RGB(s, G: s, B: s)
}
func RGB(_ R: CGFloat, G: CGFloat, B: CGFloat) -> UIColor {
    return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: 1.0)
}
func RGBA(_ R: CGFloat, G: CGFloat, B: CGFloat, A: CGFloat) -> UIColor {
    return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
}


let YVfileManager = FileManager.default



let UserDefaults = Foundation.UserDefaults.standard


let AppStoreLink = "https://itunes.apple.com/cn/app/id1216139441?mt=8"

