//
//  GameViewController.swift
//  hikerGame
//
//  Created by Theresa Gundel on 3/24/21.
//

import UIKit
import SpriteKit
import GameplayKit

//protocol nameDelegate: class {
//    func getName(n: String)
//}

protocol imageDelegate: class {
    func getImageName()
}

class GameViewController: UIViewController {
    
//    weak var nDelegate: nameDelegate? // player name
    //weak var iDelegate: imageDelegate? // image name
    
    var hikerImageName: String?
    var playerName: String!
    var score: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // hikerImageName = iDelegate?.getImageName(i: <#T##String#>)
        
        
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
    
//    func getImageName(i: String) {
//        self.hikerImageName = i
//        print(self.hikerImageName)
//    }
//
//    func passName(){
//        return nDelegate?.getName(n: <#T##String#>)
//    }

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
        print("in gvc and player name is ", self.score)
        if(segue.identifier == "gameToLeaderboard"){
            let lead: LeaderboardViewController = segue.destination as! LeaderboardViewController
            //lead.hikerImageName = hikerChoice
            lead.playerName = self.playerName
          //  lead.playerName = self.playerName
            lead.totalScore = self.score
        //    gvc.iDelegate = self
            
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
}
