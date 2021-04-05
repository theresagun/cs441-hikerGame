//
//  InstructionsViewController.swift
//  hikerGame
//
//  Created by Theresa Gundel on 4/4/21.
//

import UIKit

class InstructionsViewController: UIViewController {
    
//    var leader: LeaderboardViewController?
    var names: [String]?
    var scores: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let prep: PreplayViewController = segue.destination as! PreplayViewController
//        prep.leader = self.leader
        prep.names = self.names ?? []
        prep.scores = self.scores ?? []
        
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
