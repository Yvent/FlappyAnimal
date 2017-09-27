//
//  rulesSKScene.swift
//  flappy bird
//
//  Created by 周逸文 on 2017/9/21.
//  Copyright © 2017年 WS. All rights reserved.
//规则

import UIKit
import SnapKit
import SpriteKit

class rulesSKScene: SKScene {

    
    var menuBtn: SKSpriteNode!
    var instructionLab: UILabel!
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.white
        createScene()
//        creteUI()
        
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
        
        

//        instructionLab = SKLabelNode(text: )
        
        instructionLab = UILabel(yv_lt: "目前版本只有加法模式，第一根柱子上数字加第二根柱子上数字的和是第三根柱子，第三根柱子会有两个数字，只有从正确答案下的数字走，才能顺利通过哦，😁😁\n简单：10以内的加法计算\n一般：100以内的加法计算\n困难：10以内的二进制加法计算", ltc: UIColor.white, ts: nil, bts: 20, alg: .center, isToFit: true)
        self.view?.addSubview(instructionLab)
        instructionLab.snp.makeConstraints { (make) in
            make.width.equalTo(ScreenWidth-100)
            make.center.equalTo(self.view!)
        }
    
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touche in touches {
            let location = touche.location(in: self)
            
            if menuBtn.contains(location) == true{
                self.removeAllChildren()
                self.removeAllActions()
                self.instructionLab.removeFromSuperview()
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
