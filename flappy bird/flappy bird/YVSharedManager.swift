//
//  YVSharedManager.swift
//  WeiShow
//
//  Created by 周逸文 on 17/5/10.
//  Copyright © 2017年 WS. All rights reserved.
//

import UIKit

class YVSharedManager: NSObject {
    
    static let shared = YVSharedManager()
    private override init() {}

    ///ABOUNT - UMSHARED
    func addUMSHARED() {
        //打开调试日志
        UMSocialManager.default().openLog(true)
        UMSocialManager.default().umSocialAppkey = "59ae64d79f06fd08570007eb"
        UMSocialManager.default().setPlaform(.wechatSession, appKey: "wx565b1a037126f157", appSecret: "47c2bb2a6588fa06e40ee19706555208", redirectURL: "http://mobile.umeng.com/social")
    }
    func shareToWx()  {
        shareToAnyThing(toAny: "wx")
    }
    func shareToPy()  {
        shareToAnyThing(toAny: "py")
    }
    func shareToWb()  {
        shareToAnyThing(toAny: "wb")
    }
    
    func shareToAnyThing(toAny: String) {
        //创建分享消息对象
        let messageObject = UMSocialMessageObject()
        //创建网页内容对象
        let shareObject = UMShareWebpageObject()
        //分享标题
        shareObject.title = "小猪先飞-flappy pig(中文版)"
        //分享内容
        shareObject.descr = "【小猪先飞】- 送你一只没翅膀但是会飞的猪，像素小游戏"
        //网页图片
        shareObject.thumbImage = UIImage(named: "app_icon")
        //设置网页地址
        shareObject.webpageUrl = "https://itunes.apple.com/cn/app/id1278574803?mt=8"
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject
        
        var toany: UMSocialPlatformType?
        
        if toAny == "wx" {
            toany = .wechatSession
        }else if toAny == "py" {
            
            toany = .wechatTimeLine
        }else if  toAny == "wb" {
            toany = .sina
        }
        
        UMSocialManager.default().share(to: toany!, messageObject: messageObject, currentViewController: nil) { (data, error) in
            if (error != nil) {
                print("--------Share fail with error------\(String(describing: error))")
            }else{
//                 UserDefaults.set(true, forKey: USER_SHARED)
                print("response data is\(String(describing: data))")
            }
        }
    }
    
    
    func shareToImage(toAny: String, videoUrl: String) {
        //创建分享消息对象
        let messageObject = UMSocialMessageObject()
        //创建网页内容对象
        let shareObject = UMShareImageObject()
//        //分享标题
//        shareObject.title = "微秀-微商多格视频制作神器"
//        //分享内容
//        shareObject.descr = "微商多格视频制作神器"
//        //网页图片
//        shareObject.thumbImage = UIImage(named: "app_icon")
//        //设置网页地址
//        shareObject.videoUrl = videoUrl
//        shareObject.videoStreamUrl = videoUrl
//        shareObject.videoLowBandUrl = shareObject.videoUrl
        //分享消息对象设置分享内容对象
        
//        shareObject.shareImage = AppController.shared.sharedImage
        messageObject.shareObject = shareObject
        
        var toany: UMSocialPlatformType?
        
        if toAny == "wx" {
            toany = .wechatSession
        }else if toAny == "py" {
            
            toany = .wechatTimeLine
        }else if  toAny == "wb" {
            toany = .sina
        }
        
        
        
        UMSocialManager.default().share(to: toany!, messageObject: messageObject, currentViewController: nil) { (data, error) in
            if (error != nil) {
                print("--------Share fail with error------\(String(describing: error))")
            }else{
                print("response data is\(String(describing: data))")
            }
        }
    }
}
