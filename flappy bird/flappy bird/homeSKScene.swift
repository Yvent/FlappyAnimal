//
//  homeSKScene.swift
//  flappy bird
//
//  Created by 周逸文 on 2017/8/15.
//  Copyright © 2017年 WS. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let Pig: UInt32 = 0x1 << 1
    static let Ground: UInt32 = 0x1 << 2
    static let Wall: UInt32 = 0x1 << 3
    static let Score: UInt32 = 0x1 << 4
}
class homeSKScene: SKScene ,SKPhysicsContactDelegate{
    
    var wallIndex: Int = 1
    var addOne: Int?
    var addTwo: Int?
    var totaladd: Int?
    var ScoreLab = SKLabelNode()
    //地面
    var Ground = SKSpriteNode()
    //猪
    var Pig = SKSpriteNode()
    //墙
    var wallPair = SKNode()
    var Score: Int = 0
    var moveAndRemove = SKAction()
    var gameStarted = Bool()
    var isDied = Bool()
    var restoreBtn = SKSpriteNode()
    var sharedToWXBtn = SKSpriteNode()
    var sharedToPYQBtn = SKSpriteNode()
    var menuBtn = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        createScene()
    }
    
    func createScene() {
        self.physicsWorld.contactDelegate = self
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy:-5)
        for i in 0 ..< 2 {
            let background = SKSpriteNode(imageNamed: "背景")
            background.name = "background"
            background.position = CGPoint(x: self.frame.width/2 + CGFloat(i)*(self.frame.width), y: self.frame.height/2)
            background.size = (self.view?.bounds.size)!
            background.zPosition = 0
            self.addChild(background)
        }
        
        ScoreLab = SKLabelNode(text: "\(Score)")
        ScoreLab.position = CGPoint(x: self.frame.width/2, y: self.frame.height-100)
        ScoreLab.zPosition = 6
        ScoreLab.fontName = "04b19"
        ScoreLab.fontSize = 60
        self.addChild(ScoreLab)
        
        Ground = SKSpriteNode(imageNamed: "地面")
        Ground.size.width = ScreenWidth
        Ground.setScale(1)
        Ground.position = CGPoint(x: self.frame.width/2, y: 0 + Ground.frame.height/2)
        Ground.physicsBody = SKPhysicsBody(rectangleOf: Ground.size)
        //类别掩码: 定义了一个物体所属类别
        Ground.physicsBody?.categoryBitMask = PhysicsCategory.Ground
        //碰撞掩码: 该物体能够对另一个物体的碰撞发生反应
        Ground.physicsBody?.collisionBitMask = PhysicsCategory.Pig
        //接触测试掩码: 检测是否发生接触
        Ground.physicsBody?.contactTestBitMask = PhysicsCategory.Pig
        //是否动态
        Ground.physicsBody?.isDynamic = false
        //是否受重力影响
        Ground.physicsBody?.affectedByGravity = false
        Ground.zPosition = 3
        self.addChild(Ground)
        
        Pig = SKSpriteNode(imageNamed: "猪")
        Pig.size = CGSize(width: 60, height: 56)
        Pig.position = CGPoint(x: self.frame.width/2 - Pig.frame.width, y: self.frame.height/2)
        Pig.physicsBody = SKPhysicsBody(circleOfRadius: 56/2)
        Pig.physicsBody?.categoryBitMask = PhysicsCategory.Pig
        Pig.physicsBody?.collisionBitMask = PhysicsCategory.Ground | PhysicsCategory.Wall
        Pig.physicsBody?.contactTestBitMask = PhysicsCategory.Ground | PhysicsCategory.Wall | PhysicsCategory.Score
        Pig.physicsBody?.isDynamic = true
        Pig.physicsBody?.affectedByGravity = false
        
        Pig.zPosition = 2
        self.addChild(Pig)
        
    }
    func restoreScene() {
        self.removeAllChildren()
        self.removeAllActions()
        gameStarted = false
        isDied = false
        Score = 0
        createScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameStarted == true {
            if isDied == false {
                enumerateChildNodes(withName: "background", using: { (node, error) in
                    let bg = node as! SKSpriteNode
                    bg.position = CGPoint(x: bg.position.x - 5, y: bg.position.y)
                    if bg.position.x <= -bg.size.width/2 {
                        bg.position = CGPoint(x:bg.position.x + bg.frame.width*4/2, y: bg.position.y)
                    }
                })
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            gameStarted = true
            Pig.physicsBody?.affectedByGravity = true
            let spawn = SKAction.run {
                if self.wallIndex%3 == 0 {
                    self.createResultWalls()
                }else{
                    self.createWalls()
                    let node = self.wallPair.childNode(withName: "ScroeNode") as! SKLabelNode
                    if self.wallIndex%3 == 1 {
                        self.addOne = Int(node.text!)
                    }else if self.wallIndex%3 == 2 {
                        self.addTwo = Int(node.text!)
                        self.totaladd = self.addOne!+self.addTwo!
                    }
                }
                self.wallIndex += 1
            }
            let delay = SKAction.wait(forDuration: 1.8)
            let spawnDelay = SKAction.sequence([spawn,delay])
            let spawnDelayForever = SKAction.repeatForever(spawnDelay)
            self.run(spawnDelayForever)
            let distance = CGFloat(self.frame.width + wallPair.frame.width)*2
            
            //move动作需要一段时间
            let movePipes = SKAction.moveBy(x: -distance, y: 0, duration: TimeInterval(0.008*distance))
            let reMovePipes = SKAction.removeFromParent()
            moveAndRemove = SKAction.sequence([movePipes,reMovePipes])
            //刚体的速度
            Pig.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            Pig.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
        }else{
            Pig.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            Pig.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
        }
        
        for touche in touches {
            if isDied == true {
                let location = touche.location(in: self)
                if restoreBtn.contains(location) == true{
                    restoreScene()
                }
                if sharedToWXBtn.contains(location) == true{
                    YVSharedManager.shared.shareToWx()
                }
                if sharedToPYQBtn.contains(location) == true{
                    YVSharedManager.shared.shareToPy()
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
    
    func  createRestoreBtn() {
        restoreBtn = SKSpriteNode(imageNamed: "重新开始")
        restoreBtn.color = SKColor.red
        restoreBtn.size = CGSize(width: AdaptationWidth(250/2), height: AdaptationHeight(90/2))
        restoreBtn.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        restoreBtn.zPosition = 7
        self.addChild(restoreBtn)
        //按钮出现时的动画
        restoreBtn.setScale(0)
        restoreBtn.run(SKAction.scale(to: 1.5, duration: 0.3))
        wallIndex = 1
    }
    
    func createMenuBtn()  {
        menuBtn = SKSpriteNode(imageNamed: "菜单")
        //        menuBtn.size = CGSize(width: 90/2, height: 90/2)
        menuBtn.position = CGPoint(x: 50, y: self.frame.height-50)
        menuBtn.zPosition = 7
        self.addChild(menuBtn)
        
        //按钮出现时的动画
        menuBtn.setScale(0)
        menuBtn.run(SKAction.scale(to: 1, duration: 0.3))
    }
    
    func createSharedBtn() {
        sharedToWXBtn = SKSpriteNode(imageNamed: "pig_weixin")
        sharedToWXBtn.color = SKColor.red
        sharedToWXBtn.size = CGSize(width: AdaptationHeight(90/2), height: AdaptationHeight(90/2))
        sharedToWXBtn.position = CGPoint(x: self.frame.width/2-AdaptationHeight(90/2), y: self.frame.height/2+AdaptationHeight(60))
        sharedToWXBtn.zPosition = 7
        self.addChild(sharedToWXBtn)
        //按钮出现时的动画
        sharedToWXBtn.setScale(0)
        sharedToWXBtn.run(SKAction.scale(to: 1.2, duration: 0.3))
        sharedToPYQBtn = SKSpriteNode(imageNamed: "pig_pyq")
        sharedToPYQBtn.color = SKColor.red
        sharedToPYQBtn.size = CGSize(width: AdaptationHeight(90/2), height: AdaptationHeight(90/2))
        sharedToPYQBtn.position = CGPoint(x: self.frame.width/2+AdaptationHeight(90/2), y: self.frame.height/2+AdaptationHeight(60))
        sharedToPYQBtn.zPosition = 7
        self.addChild(sharedToPYQBtn)
        //按钮出现时的动画
        sharedToPYQBtn.setScale(0)
        sharedToPYQBtn.run(SKAction.scale(to: 1.2, duration: 0.3))
        
        
        createMenuBtn()
    }
    func createWalls() {
        //为每个墙创建一条线，计数使用
        let ScroeNode = SKLabelNode()
        ScroeNode.name = "ScroeNode"
        ScroeNode.color = SKColor.blue
        ScroeNode.text = "\(CGFloat.randomF(to: UInt32(LevelCount)))"
        ScroeNode.fontName = "04b19"
        ScroeNode.fontSize = 60
        //一定要实例化
        ScroeNode.position = CGPoint(x: self.frame.width+AdaptationWidth(59), y:  self.frame.height/2 + AdaptationWidth(25) )
        ScroeNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: AdaptationWidth(59), height: AdaptationWidth(59*2)))
        ScroeNode.physicsBody?.categoryBitMask = PhysicsCategory.Score
        ScroeNode.physicsBody?.collisionBitMask = 0
        ScroeNode.physicsBody?.contactTestBitMask = PhysicsCategory.Pig
        ScroeNode.physicsBody?.isDynamic = false
        ScroeNode.physicsBody?.affectedByGravity = false
        
        //节点，方便管理多个精灵，并不是父控件，和位置没有关系
        wallPair = SKNode()
        wallPair.name = "wallPair"
        let topwall = SKSpriteNode(imageNamed: "tree")
        let botwall = SKSpriteNode(imageNamed: "tree")
        topwall.size = CGSize(width: AdaptationWidth(59), height: AdaptationHeight(300))
        botwall.size = CGSize(width: AdaptationWidth(59), height: AdaptationHeight(300))
        topwall.position = CGPoint(x: self.frame.width+AdaptationWidth(59), y: self.frame.height/2 + AdaptationWidth(300))
        botwall.position = CGPoint(x: self.frame.width+AdaptationWidth(59), y: self.frame.height/2 - AdaptationWidth(200))
        
        topwall.physicsBody = SKPhysicsBody(rectangleOf: topwall.size)
        topwall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        topwall.physicsBody?.collisionBitMask = PhysicsCategory.Pig
        topwall.physicsBody?.contactTestBitMask = PhysicsCategory.Pig
        topwall.physicsBody?.isDynamic = false
        topwall.physicsBody?.affectedByGravity = false
        
        botwall.physicsBody = SKPhysicsBody(rectangleOf: topwall.size)
        botwall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        botwall.physicsBody?.collisionBitMask = PhysicsCategory.Pig
        botwall.physicsBody?.contactTestBitMask = PhysicsCategory.Pig
        botwall.physicsBody?.isDynamic = false
        botwall.physicsBody?.affectedByGravity = false
        topwall.zRotation = CGFloat(Double.pi)
        wallPair.addChild(topwall)
        wallPair.addChild(botwall)
        //控件的添加顺序
        wallPair.zPosition = 1
        let randomPostion = CGFloat.random(min: -100, max: 100)
        wallPair.position.y = wallPair.position.y + randomPostion
        wallPair.run(moveAndRemove)
        wallPair.addChild(ScroeNode)
        self.addChild(wallPair)
    }
    func createResultWalls() {
        let randomBool = CGFloat.randomF(to: 2)
        //为每个墙创建一条线，计数使用
        let topScroeNode = SKLabelNode()
        topScroeNode.name = "topScroeNode"
        topScroeNode.color = SKColor.blue
        topScroeNode.fontName = "04b19"
        topScroeNode.fontSize = 60
        //一定要实例化
        topScroeNode.position = CGPoint(x: self.frame.width+AdaptationWidth(59), y:  self.frame.height/2 + AdaptationWidth(100) )
        topScroeNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: AdaptationWidth(59), height: AdaptationWidth(59*2)))
        topScroeNode.physicsBody?.categoryBitMask = PhysicsCategory.Score
        topScroeNode.physicsBody?.collisionBitMask = 0
        topScroeNode.physicsBody?.contactTestBitMask = PhysicsCategory.Pig
        topScroeNode.physicsBody?.isDynamic = false
        topScroeNode.physicsBody?.affectedByGravity = false
        
        let botScroeNode = SKLabelNode()
        botScroeNode.name = "botScroeNode"
        botScroeNode.color = SKColor.blue
        botScroeNode.fontName = "04b19"
        botScroeNode.fontSize = 60
        //一定要实例化
        botScroeNode.position = CGPoint(x: self.frame.width+AdaptationWidth(59), y:  self.frame.height/2 - AdaptationWidth(150) )
        botScroeNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: AdaptationWidth(59), height: AdaptationWidth(59)))
        botScroeNode.physicsBody?.categoryBitMask = PhysicsCategory.Score
        botScroeNode.physicsBody?.collisionBitMask = 0
        botScroeNode.physicsBody?.contactTestBitMask = PhysicsCategory.Pig
        botScroeNode.physicsBody?.isDynamic = false
        botScroeNode.physicsBody?.affectedByGravity = false
        
        if randomBool == 0 {
            topScroeNode.text = "\(self.totaladd!)"
            botScroeNode.text = "\(CGFloat.randomF(to: UInt32(LevelCount)))"
        }else{
            
            topScroeNode.text = "\(CGFloat.randomF(to: UInt32(LevelCount)))"
            botScroeNode.text = "\(self.totaladd!)"
        }
        
        //节点，方便管理多个精灵，并不是父控件，和位置没有关系
        wallPair = SKNode()
        wallPair.name = "wallPair"
        let topwall = SKSpriteNode(imageNamed: "tree")
        let botwall = SKSpriteNode(imageNamed: "tree")
        let midwall = SKSpriteNode(imageNamed: "tree")
        topwall.size = CGSize(width: AdaptationWidth(59), height: AdaptationHeight(300))
        botwall.size = CGSize(width: AdaptationWidth(59), height: AdaptationHeight(300))
        midwall.size = CGSize(width: AdaptationWidth(59), height: AdaptationHeight(50))
        topwall.position = CGPoint(x: self.frame.width+AdaptationWidth(59), y: self.frame.height/2 + AdaptationWidth(400))
        botwall.position = CGPoint(x: self.frame.width+AdaptationWidth(59), y: self.frame.height/2 - AdaptationWidth(400))
        midwall.position = CGPoint(x: self.frame.width+AdaptationWidth(59), y: self.frame.height/2 + AdaptationWidth(0))
        
        topwall.physicsBody = SKPhysicsBody(rectangleOf: topwall.size)
        topwall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        topwall.physicsBody?.collisionBitMask = PhysicsCategory.Pig
        topwall.physicsBody?.contactTestBitMask = PhysicsCategory.Pig
        topwall.physicsBody?.isDynamic = false
        topwall.physicsBody?.affectedByGravity = false
        
        botwall.physicsBody = SKPhysicsBody(rectangleOf: topwall.size)
        botwall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        botwall.physicsBody?.collisionBitMask = PhysicsCategory.Pig
        botwall.physicsBody?.contactTestBitMask = PhysicsCategory.Pig
        botwall.physicsBody?.isDynamic = false
        botwall.physicsBody?.affectedByGravity = false
        
        midwall.physicsBody = SKPhysicsBody(rectangleOf: midwall.size)
        midwall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        midwall.physicsBody?.collisionBitMask = PhysicsCategory.Pig
        midwall.physicsBody?.contactTestBitMask = PhysicsCategory.Pig
        midwall.physicsBody?.isDynamic = false
        midwall.physicsBody?.affectedByGravity = false
        
        topwall.zRotation = CGFloat(Double.pi)
        
        wallPair.addChild(topwall)
        wallPair.addChild(botwall)
        wallPair.addChild(midwall)
        //控件的添加顺序
        wallPair.zPosition = 1
        wallPair.run(moveAndRemove)
        
        wallPair.addChild(topScroeNode)
        wallPair.addChild(botScroeNode)
        self.addChild(wallPair)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodya = contact.bodyA
        let bodyb = contact.bodyB
        if isDied == false {
            //猪与线接触
            if bodya.categoryBitMask == PhysicsCategory.Pig && bodyb.categoryBitMask == PhysicsCategory.Score {
                Score += 1
                ScoreLab.text = "\(Score)"
                let node = bodyb.node as! SKLabelNode
                if node.name == "botScroeNode" || node.name == "topScroeNode"{
                    let scoreInt = Int(node.text!)
                    if scoreInt! != self.totaladd! {
                        isDied = true
                        //函数可以取得所有具有name的nodes，这里取得node，并停止。
                        enumerateChildNodes(withName: "wallPair", using: { (node, error) in
                            node.speed = 0
                            self.removeAllActions()
                        })
                        createRestoreBtn()
                        createSharedBtn()
                    }
                }
                bodyb.node?.removeFromParent()
            } else if bodyb.categoryBitMask == PhysicsCategory.Pig && bodya.categoryBitMask == PhysicsCategory.Score {
                Score += 1
                ScoreLab.text = "\(Score)"
                let node = bodya.node as! SKLabelNode
                if node.name == "botScroeNode" || node.name == "topScroeNode"{
                    let scoreInt = Int(node.text!)
                    if scoreInt! != self.totaladd! {
                        isDied = true
                        //函数可以取得所有具有name的nodes，这里取得node，并停止。
                        enumerateChildNodes(withName: "wallPair", using: { (node, error) in
                            node.speed = 0
                            self.removeAllActions()
                        })
                        createRestoreBtn()
                        createSharedBtn()
                    }
                }
                bodya.node?.removeFromParent()
            }
            //猪与墙接触
            if bodya.categoryBitMask == PhysicsCategory.Pig && bodyb.categoryBitMask == PhysicsCategory.Wall || bodyb.categoryBitMask == PhysicsCategory.Pig && bodya.categoryBitMask == PhysicsCategory.Wall{
                isDied = true
                //函数可以取得所有具有name的nodes，这里取得node，并停止。
                enumerateChildNodes(withName: "wallPair", using: { (node, error) in
                    node.speed = 0
                    self.removeAllActions()
                })
                createRestoreBtn()
                createSharedBtn()
            }
            
            //猪与地面接触
            if bodya.categoryBitMask == PhysicsCategory.Pig && bodyb.categoryBitMask == PhysicsCategory.Ground || bodyb.categoryBitMask == PhysicsCategory.Pig && bodya.categoryBitMask == PhysicsCategory.Ground{
                isDied = true
                //函数可以取得所有具有name的nodes，这里取得node，并停止。
                enumerateChildNodes(withName: "wallPair", using: { (node, error) in
                    node.speed = 0
                    self.removeAllActions()
                })
                createRestoreBtn()
                createSharedBtn()
            }
        }
    }
}
