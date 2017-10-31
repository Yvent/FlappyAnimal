//
//  SpriteKitEXT.swift
//  flappy bird
//
//  Created by 周逸文 on 2017/10/25.
//  Copyright © 2017年 WS. All rights reserved.
//

import Foundation
import SpriteKit


extension SKSpriteNode{
    
    func configuration(name: String?,
                        size: CGSize?,
                        position: CGPoint?,
                        physicsBody: SKPhysicsBody?,
                        zPosition: CGFloat?) {
        self.name = name
        if let yvsize = size { self.size = yvsize}
        if let yvposition = position { self.position = yvposition}
        self.physicsBody = physicsBody
        if let yvzPosition = zPosition { self.zPosition = yvzPosition}
    }
    
}

extension  SKPhysicsBody {
    
    
    func configuration(categoryBitMask: UInt32?,
                       collisionBitMask: UInt32?,
                       contactTestBitMask: UInt32?,
                       isDynamic: Bool,
                       affectedByGravity: Bool) {
        //类别掩码: 定义了一个物体所属类别
        if let yvcategoryBitMask = categoryBitMask {
            self.categoryBitMask = yvcategoryBitMask
        }
         //碰撞掩码: 该物体能够对另一个物体的碰撞发生反应
        if let yvcollisionBitMask = collisionBitMask {
            self.collisionBitMask = yvcollisionBitMask
        }
        //接触测试掩码: 检测是否发生接触
        if let yvcontactTestBitMask = contactTestBitMask {
            self.contactTestBitMask = yvcontactTestBitMask
        }
        //是否动态
        self.isDynamic = isDynamic
        //是否受重力影响
        self.affectedByGravity = affectedByGravity
        
    }
    
}

extension SKLabelNode {
    

    func configuration(name: String?,
                       position: CGPoint?,
                       fontName: String?,
                       fontSize: CGFloat?,
                       physicsBody: SKPhysicsBody?,
                       zPosition: CGFloat?) {
        
        self.name = name
        if let yvposition = position {
            self.position = yvposition
        }
        self.fontName = fontName
        if let yvfontSize = fontSize {
            self.fontSize = yvfontSize
        }
        self.physicsBody = physicsBody
        if let yvzPosition = zPosition {
            self.zPosition = yvzPosition
        }
        
    }
}
extension SKNode {

    func addChilds(nodes: Array<SKNode>) {
        _ = nodes.map{addChild($0)}
    }

}
