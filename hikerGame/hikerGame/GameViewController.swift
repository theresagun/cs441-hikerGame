//
//  GameViewController.swift
//  hikerGame
//
//  Created by Theresa Gundel on 3/24/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

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
        if(segue.identifier == "leaderboard"){
            // LeaderboardViewController * dest = segue.destination
            //TODO here we can share data between VCs?
        }
    }
    
//    prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//        if([segue.identifier isEqualToString:@"mainToXerox"]){
//            NSLog(@"xerox");
//            SecondViewController *destinationVc = segue.destinationViewController;
//            Connector *connectorClass = [[Connector alloc] init];
//            connectorClass.isXerox = isXerox;
//            destinationVc.connectorClass = connectorClass;
//        }
}
