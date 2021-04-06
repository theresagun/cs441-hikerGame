//
//  GameViewController.swift
//  hikerGame
//
//  Created by Theresa Gundel on 3/24/21.
//

import UIKit
import SpriteKit
import GameplayKit
import CoreData

class GameViewController: UIViewController {
    
    var hikerImageName: String?
    var playerName: String!
    var score: Int?
    
    var names: [String]?
    var scores: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            let scene = GameScene(size: CGSize(width: 750, height: 1334))
            scene.scaleMode = .aspectFill //scale to fit window
            scene.viewController = self
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
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

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let lead: LeaderboardViewController = segue.destination as! LeaderboardViewController
        lead.names = self.names ?? []
        lead.scores = self.scores ?? []
        lead.playerName = self.playerName
        lead.totalScore = self.score
        }

}

