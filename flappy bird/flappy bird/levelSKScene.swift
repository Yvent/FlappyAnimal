//
//  levelSKScene.swift
//  flappy bird
//
//  Created by 周逸文 on 2017/9/19.
//  Copyright © 2017年 WS. All rights reserved.
//

import UIKit
import SpriteKit
class levelSKScene: SKScene {
    
    
    var menuBtn: SKSpriteNode!
    //简单
    var simpleNode: SKSpriteNode!
    //一般
    var nomalNode: SKSpriteNode!
    //困难
    var difficultNode: SKSpriteNode!
    
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
        
        menuBtn = SKSpriteNode(imageNamed: "菜单")
        menuBtn.position = CGPoint(x: 50, y: self.frame.height-50)
        menuBtn.zPosition = 1
        self.addChild(menuBtn)
        
        simpleNode = SKSpriteNode(imageNamed: "简单")
        simpleNode.size = CGSize(width: AdaptationWidth(240), height: AdaptationWidth(80))
        simpleNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2+100)
        simpleNode.zPosition = 1
        self.addChild(simpleNode)
        
        nomalNode = SKSpriteNode(imageNamed: "一般")
        nomalNode.size = CGSize(width: AdaptationWidth(240), height: AdaptationWidth(80))
        nomalNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        nomalNode.zPosition = 1
        self.addChild(nomalNode)
        
        difficultNode = SKSpriteNode(imageNamed: "困难")
        difficultNode.size = CGSize(width: AdaptationWidth(240), height: AdaptationWidth(80))
        difficultNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2-100)
        difficultNode.zPosition = 1
        self.addChild(difficultNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touche in touches {
            let location = touche.location(in: self)
            if simpleNode.contains(location) == true{
                LevelCount = 10
            }
            if nomalNode.contains(location) == true{
                LevelCount = 100
            }
            if difficultNode.contains(location) == true{
                LevelCount = 200
            }
            if menuBtn.contains(location) == true{
                self.removeAllChildren()
                self.removeAllActions()
                //跳转到菜单栏
                //声明下一个场景的实例
                let secondScene = menuSKScene(size: self.size)
                //场景过渡动画
                let doors = SKTransition.doorsOpenVertical(withDuration: 0.5)
                //带动画的场景跳转
                self.view?.presentScene(secondScene,transition:doors)
            }
        }
    }
}
