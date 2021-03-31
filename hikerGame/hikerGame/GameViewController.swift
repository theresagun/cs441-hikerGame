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
        NotificationCenter.default.addObserver(self, selector: Selector(("methodOFReceivedNotication:")), name:NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)

        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
            //    print(scene.size.dictionaryRepresentation)
           // let scene = GameScene(size: CGSize(width: 750, height: 1334))
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                                
                // Present the scene
                view.presentScene(scene)
              //  scene.viewController = self

            }
            
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
    
    func methodOFReceivedNotication(notification: NSNotification){
        NSLog("here")
       // self.performSegue(withIdentifier: "gameToLeaderboard", sender: self)
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
