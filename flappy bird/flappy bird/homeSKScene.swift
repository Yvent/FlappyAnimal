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
struct LevelType {
    static let Binary: String = "Binary"
    static let Decimal: String = "Decimal"
}



class homeSKScene: SKScene ,SKPhysicsContactDelegate{
    
    var wallIndex: Int = 1
    var addOne: Int?
    var addTwo: Int?
    var totaladdStr: String?
    var totaladdStrCopy: String?
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
            background.configuration(name: "background", size: self.view?.bounds.size, position: CGPoint(x: self.frame.width/2 + CGFloat(i)*(self.frame.width), y: self.frame.height/2), physicsBody: nil, zPosition: 0)
            self.addChild(background)
        }
        ScoreLab = SKLabelNode(text: "\(Score)")
        ScoreLab.configuration(name: nil, position: CGPoint(x: self.frame.width/2, y: self.frame.height-100), fontName: "04b19", fontSize: 60, physicsBody: nil, zPosition: 6)
        Ground = SKSpriteNode(imageNamed: "地面")
        let Groundbody = SKPhysicsBody(rectangleOf: Ground.size)
        Groundbody.configuration(categoryBitMask: PhysicsCategory.Ground, collisionBitMask: PhysicsCategory.Pig, contactTestBitMask: PhysicsCategory.Pig, isDynamic: false, affectedByGravity: false)
        Ground.configuration(name: nil, size: CGSize(width: ScreenWidth, height: Ground.size.height), position: CGPoint(x: self.frame.width/2, y: 0 + Ground.frame.height/2), physicsBody: Groundbody, zPosition: 3)
        
        

     
        Pig =  SKSpriteNode(imageNamed:"猪")

        let Pigbody = SKPhysicsBody(circleOfRadius: 56/2)
        Pigbody.configuration(categoryBitMask: PhysicsCategory.Pig, collisionBitMask: PhysicsCategory.Ground | PhysicsCategory.Wall, contactTestBitMask: PhysicsCategory.Ground | PhysicsCategory.Wall | PhysicsCategory.Score, isDynamic: true, affectedByGravity: false)
        Pig.configuration(name: nil, size: CGSize(width: 60, height: 56), position: CGPoint(x: self.frame.width/2 - 60, y: self.frame.height/2), physicsBody: Pigbody, zPosition: 2)
        self.addChilds(nodes: [ScoreLab,Ground,Pig])
        
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
                        self.addOne = Int(node.text!.getDecimalByBinary())
                    }else if self.wallIndex%3 == 2 {
                        self.addTwo = Int(node.text!.getDecimalByBinary())
                        let totaladd = self.addOne!+self.addTwo!
                        if fLevelType == LevelType.Decimal {
                            self.totaladdStr = "\(totaladd)"
                            self.totaladdStrCopy = "\(totaladd)"
                        }else if fLevelType == LevelType.Binary {
                            var intStr = "\(totaladd)"
                            print("intStr====\(intStr)")
                            self.totaladdStrCopy = intStr
                            self.totaladdStr = intStr.getBinaryByDecimal()
                        }
                        
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
        restoreBtn.configuration(name: nil, size: CGSize(width: AdaptationWidth(250/2), height: AdaptationHeight(90/2))
            , position: CGPoint(x: self.frame.width/2, y: self.frame.height/2), physicsBody: nil, zPosition: 7)
        self.addChild(restoreBtn)
        //按钮出现时的动画
        restoreBtn.setScale(0)
        restoreBtn.run(SKAction.scale(to: 1.5, duration: 0.3))
        wallIndex = 1
    }
    
    func createMenuBtn()  {
        menuBtn = SKSpriteNode(imageNamed: "菜单")
        menuBtn.configuration(name: nil, size: nil, position: CGPoint(x: 50, y: self.frame.height-50), physicsBody: nil, zPosition: 7)
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
        let Scroebody = SKPhysicsBody(rectangleOf: CGSize(width: AdaptationWidth(59), height: AdaptationWidth(59*2)))
        Scroebody.configuration(categoryBitMask: PhysicsCategory.Score, collisionBitMask: 0, contactTestBitMask: PhysicsCategory.Pig, isDynamic: false, affectedByGravity: false)
        ScroeNode.configuration(name: "ScroeNode", position: CGPoint(x: self.frame.width+AdaptationWidth(59), y:  self.frame.height/2 + AdaptationWidth(25) ), fontName: "04b19", fontSize: 60, physicsBody: Scroebody, zPosition: nil)
        if fLevelType == LevelType.Decimal {
            ScroeNode.text = "\(CGFloat.randomF(to: UInt32(LevelCount)))"
        }else if fLevelType == LevelType.Binary {
            var intStr = "\(CGFloat.randomF(to: UInt32(LevelCount)))"
            ScroeNode.text = intStr.getBinaryByDecimal()
        }
        //节点，方便管理多个精灵，并不是父控件，和位置没有关系
        wallPair = SKNode()
        wallPair.name = "wallPair"
        let topwall = SKSpriteNode(imageNamed: "tree")
        let botwall = SKSpriteNode(imageNamed: "tree")
        let topwallsize = CGSize(width: AdaptationWidth(59), height: AdaptationHeight(300))
        let topwallposition = CGPoint(x: self.frame.width+AdaptationWidth(59), y: self.frame.height/2 + AdaptationWidth(300))
        let topwallbody = SKPhysicsBody(rectangleOf: topwallsize)
        topwallbody.configuration(categoryBitMask: PhysicsCategory.Wall, collisionBitMask: PhysicsCategory.Pig, contactTestBitMask: PhysicsCategory.Pig, isDynamic: false, affectedByGravity: false)
        topwall.configuration(name: nil, size: topwallsize, position: topwallposition, physicsBody: topwallbody, zPosition: nil)
        let botwallposition =  CGPoint(x: self.frame.width+AdaptationWidth(59), y: self.frame.height/2 - AdaptationWidth(200))
        let botwallbody = SKPhysicsBody(rectangleOf: topwallsize)
        botwallbody.configuration(categoryBitMask: PhysicsCategory.Wall, collisionBitMask: PhysicsCategory.Pig, contactTestBitMask: PhysicsCategory.Pig, isDynamic: false, affectedByGravity: false)
        botwall.configuration(name: nil, size: topwallsize, position: botwallposition, physicsBody: botwallbody, zPosition: nil)
        topwall.zRotation = CGFloat(Double.pi)
        wallPair.addChilds(nodes: [topwall,botwall])
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
        let topScroebody = SKPhysicsBody(rectangleOf: CGSize(width: AdaptationWidth(59), height: AdaptationWidth(59*2)))
        topScroebody.configuration(categoryBitMask: PhysicsCategory.Score, collisionBitMask: 0, contactTestBitMask: PhysicsCategory.Pig, isDynamic: false, affectedByGravity: false)
        topScroeNode.configuration(name: "topScroeNode", position: CGPoint(x: self.frame.width+AdaptationWidth(59), y:  self.frame.height/2 + AdaptationWidth(100) ), fontName: "04b19", fontSize: 60, physicsBody: topScroebody, zPosition: nil)
        
        
        let botScroeNode = SKLabelNode()
        let botScroebody = SKPhysicsBody(rectangleOf: CGSize(width: AdaptationWidth(59), height: AdaptationWidth(59)))
        botScroebody.configuration(categoryBitMask: PhysicsCategory.Score, collisionBitMask: 0, contactTestBitMask: PhysicsCategory.Pig, isDynamic: false, affectedByGravity: false)
        
        botScroeNode.configuration(name: "botScroeNode", position: CGPoint(x: self.frame.width+AdaptationWidth(59), y:  self.frame.height/2 - AdaptationWidth(150) ), fontName: "04b19", fontSize: 60, physicsBody: botScroebody, zPosition: nil)
        
        
        if randomBool == 0 {
            if fLevelType == LevelType.Decimal {
                topScroeNode.text = self.totaladdStrCopy!
                botScroeNode.text = "\(CGFloat.randomF(to: UInt32(LevelCount)))"
            }else if fLevelType == LevelType.Binary {
                var intStr = "\(CGFloat.randomF(to: UInt32(LevelCount)))"
                var aintStr = self.totaladdStrCopy!
                topScroeNode.text = aintStr.getBinaryByDecimal()
                botScroeNode.text = intStr.getBinaryByDecimal()
            }
        }else{
            if fLevelType == LevelType.Decimal {
                topScroeNode.text = "\(CGFloat.randomF(to: UInt32(LevelCount)))"
                botScroeNode.text = self.totaladdStrCopy!
            }else if fLevelType == LevelType.Binary {
                var intStr = "\(CGFloat.randomF(to: UInt32(LevelCount)))"
                var aintStr = self.totaladdStrCopy!
                topScroeNode.text = intStr.getBinaryByDecimal()
                botScroeNode.text = aintStr.getBinaryByDecimal()
            }
        }
        //节点，方便管理多个精灵，并不是父控件，和位置没有关系
        wallPair = SKNode()
        wallPair.name = "wallPair"
        let topwall = SKSpriteNode(imageNamed: "tree")
        let botwall = SKSpriteNode(imageNamed: "tree")
        let midwall = SKSpriteNode(imageNamed: "tree")
        let topwallsize = CGSize(width: AdaptationWidth(59), height: AdaptationHeight(300))
        let topwallposition = CGPoint(x: self.frame.width+AdaptationWidth(59), y: self.frame.height/2 + AdaptationWidth(400))
        let topwallbody = SKPhysicsBody(rectangleOf: topwallsize)
        topwallbody.configuration(categoryBitMask: PhysicsCategory.Wall, collisionBitMask: PhysicsCategory.Pig, contactTestBitMask: PhysicsCategory.Pig, isDynamic: false, affectedByGravity: false)
        topwall.configuration(name: nil, size: topwallsize, position: topwallposition, physicsBody: topwallbody, zPosition: nil)
        let botwallposition =  CGPoint(x: self.frame.width+AdaptationWidth(59), y: self.frame.height/2 - AdaptationWidth(400))
        let botwallbody = SKPhysicsBody(rectangleOf: topwallsize)
        botwallbody.configuration(categoryBitMask: PhysicsCategory.Wall, collisionBitMask: PhysicsCategory.Pig, contactTestBitMask: PhysicsCategory.Pig, isDynamic: false, affectedByGravity: false)
        botwall.configuration(name: nil, size: topwallsize, position: botwallposition, physicsBody: botwallbody, zPosition: nil)
        let midwallsize = CGSize(width: AdaptationWidth(59), height: AdaptationHeight(50))
        let midwallposition = CGPoint(x: self.frame.width+AdaptationWidth(59), y: self.frame.height/2 + AdaptationWidth(0))
        let midwallbody = SKPhysicsBody(rectangleOf: midwallsize)
        midwallbody.configuration(categoryBitMask: PhysicsCategory.Wall, collisionBitMask: PhysicsCategory.Pig, contactTestBitMask: PhysicsCategory.Pig, isDynamic: false, affectedByGravity: false)
        midwall.configuration(name: nil, size: midwallsize, position: midwallposition, physicsBody: midwallbody, zPosition: nil)
        topwall.zRotation = CGFloat(Double.pi)
        wallPair.addChilds(nodes: [topwall,botwall,midwall])
        //控件的添加顺序
        wallPair.zPosition = 1
        wallPair.run(moveAndRemove)
        wallPair.addChilds(nodes: [topScroeNode,botScroeNode])
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
                    if node.text! != totaladdStr! {
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
                    if node.text! != self.totaladdStr! {
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
