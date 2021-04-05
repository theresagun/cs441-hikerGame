//
//  ViewController.swift
//  hikerGame
//
//  Created by Theresa Gundel on 3/31/21.
//

import UIKit

class ViewController: UIViewController {
    
//    var leader: LeaderboardViewController!
    var names: [String]?
    var scores: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        leader = LeaderboardViewController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "mainToInstructions"){
            let instr: InstructionsViewController = segue.destination as! InstructionsViewController
//            instr.leader = self.leader
            instr.names = self.names
            instr.scores = self.scores
        }
        else if(segue.identifier == "mainToPreplay"){
            let prep: PreplayViewController = segue.destination as! PreplayViewController
//            prep.leader = self.leader
            prep.names = self.names
            prep.scores = self.scores
        }
        else if(segue.identifier == "mainToLeader"){
//            segue.destination = self.leader
            let lead: LeaderboardViewController = segue.destination as! LeaderboardViewController
            lead.names = self.names ?? []
            lead.scores = self.scores ?? []
        }
        
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
