//
//  GameViewController.swift
//  flappy bird
//
//  Created by 周逸文 on 2017/8/15.
//  Copyright © 2017年 WS. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
class GameViewController: UIViewController {

    override func viewDidLoad() {
  
        
        if let view = self.view as! SKView? {
            let scene = menuSKScene(size: CGSize(width: view.bounds.size.width, height: view.bounds.size.height))
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            //使用zpostion有效
            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    



}
