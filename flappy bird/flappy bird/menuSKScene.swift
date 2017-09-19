//
//  menuSKScene.swift
//  flappy bird
//
//  Created by 周逸文 on 2017/9/17.
//  Copyright © 2017年 WS. All rights reserved.
//菜单页

import UIKit
import SpriteKit


class menuSKScene: SKScene {
    
    var startNode: SKSpriteNode!
    var levelNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.white
        createScene()
    }
    
    func createScene() {
        let background = SKSpriteNode(imageNamed: "背景")
        background.name = "background"
        background.position = CGPoint(x: self.frame.width/2 + CGFloat(0)*(self.frame.width), y: self.frame.height/2)
        background.size = (self.view?.bounds.size)!
        background.zPosition = 0
        self.addChild(background)
        
        startNode = SKSpriteNode(imageNamed: "开始")
        startNode.size = CGSize(width: AdaptationWidth(240), height: AdaptationWidth(80))
        startNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2+80)
        startNode.zPosition = 1
        self.addChild(startNode)
        
        levelNode = SKSpriteNode(imageNamed: "难度")
        levelNode.size = CGSize(width: AdaptationWidth(240), height: AdaptationWidth(80))
        levelNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2-80)
        levelNode.zPosition = 1
        self.addChild(levelNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touche in touches {
            let location = touche.location(in: self)
            if startNode.contains(location) == true{
                self.removeAllChildren()
                self.removeAllActions()
                //声明下一个场景的实例
                let secondScene = homeSKScene(size: self.size)
                //场景过渡动画
                let doors = SKTransition.doorsOpenVertical(withDuration: 0.5)
                //带动画的场景跳转
                self.view?.presentScene(secondScene,transition:doors)
                return
            }
            if levelNode.contains(location) == true{
                self.removeAllChildren()
                self.removeAllActions()
                //声明下一个场景的实例
                let secondScene = levelSKScene(size: self.size)
                //场景过渡动画
                let doors = SKTransition.doorsOpenVertical(withDuration: 0.5)
                //带动画的场景跳转
                self.view?.presentScene(secondScene,transition:doors)
                return
            }
        }
    }
}
