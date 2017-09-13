//
//  RandomExten.swift
//  flappy bird
//
//  Created by 周逸文 on 2017/8/17.
//  Copyright © 2017年 WS. All rights reserved.
//

import Foundation
import UIKit

public extension CGFloat{

  public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
 public static  func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min
    }
    
  public  static func randomF(to: UInt32) -> Int {
       return Int(arc4random() % to)
    }
}
