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
    
    var hikerImageName: String?
    var playerName: String!
    var score: Int?
    
//    var leader: LeaderboardViewController?
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
    
//    @IBAction func unwind(sender: UIStoryboardSegue) {
////        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
////
////            // Add a new meal.
////            let newIndexPath = IndexPath(row: meals.count, section: 0)
////
////            meals.append(meal)
////            tableView.insertRows(at: [newIndexPath], with: .automatic)
//        //}
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let lead: LeaderboardViewController = segue.destination as! LeaderboardViewController
        lead.names = self.names ?? []
        lead.scores = self.scores ?? [] 
//        segue.destination = self.leader!
//        if(segue.identifier == "gameToLeaderboard"){
//            //lead.hikerImageName = hikerChoice
//            lead.playerName = self.playerName
            lead.playerName = self.playerName
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

