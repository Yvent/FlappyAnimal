//
//  levelSKScene.swift
//  flappy bird
//
//  Created by 周逸文 on 2017/9/19.
//  Copyright © 2017年 WS. All rights reserved.
//

import UIKit
import SnapKit
import SpriteKit
class levelSKScene: SKScene,UITableViewDelegate,UITableViewDataSource {
    
    
    var fTableView: UITableView!
    let images = ["简单","一般","困难"]
     let imagesSelect = ["简单_select","一般_select","困难_select"]
    let levelSelect = [10,100,5]
    let fLevelTypes = [LevelType.Decimal,LevelType.Decimal,LevelType.Binary]
    
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
         creteUI()
    
    }
    
    func creteUI() {
        fTableView = UITableView(yv_bc: UIColor.white, any: self, rh: AdaptationWidth(80), tabstyle: .plain, style: .none)
        self.view?.addSubview(fTableView)
        fTableView.snp.makeConstraints { (make) in
            make.width.equalTo(AdaptationWidth(240))
            make.height.equalTo(AdaptationWidth(240))
            make.center.equalTo(self.view!)
        }
        
        fTableView.register(levelSKCell.self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as levelSKCell
        cell.imageV.image = UIImage(named: images[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! levelSKCell
        cell.imageV.image = UIImage(named: imagesSelect[indexPath.row])
        
        LevelCount = levelSelect[indexPath.row]
        fLevelType = fLevelTypes[indexPath.row]
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! levelSKCell
        cell.imageV.image = UIImage(named: images[indexPath.row])
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

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touche in touches {
            let location = touche.location(in: self)

            if menuBtn.contains(location) == true{
                self.removeAllChildren()
                self.removeAllActions()
                self.fTableView.removeFromSuperview()
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

class levelSKCell: UITableViewCell {
    
    var imageV: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        initUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        imageV = UIImageView(yv_named: "", rd: 0, bc: nil, bdc: nil, bdw: nil)
        self.contentView.addSubview(imageV)
        imageV.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
  
    }
}
