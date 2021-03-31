//
//  LeaderboardViewController.swift
//  hikerGame
//
//  Created by Theresa Gundel on 3/31/21.
//

import UIKit

//protocol NameDelegate {
//    func getName(n: String)
//}

class LeaderboardViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    var playerName: String?
    var totalScore: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if let name = self.playerName{
//            label.text = name
//        }
//        else{
//            label.text = "Anonymous"
//        }
        if let tot = self.totalScore{
            label.text = String(tot)
        }
        else{
            label.text = "NO"
        }
    }
    
//    func getName(n: String) {
//        currName = n
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
