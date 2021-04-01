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

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //@IBOutlet var label: UILabel!
    @IBOutlet var tableView: UITableView!
    var names: [String] = []
    var scores: [String] = []

    var playerName: String?
    var totalScore: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        if let score = self.totalScore{
            if let name = self.playerName{
                addToLeaderboard(n: name, s: score)
            }
            else{
                NSLog("invalid name")
            }
        }
        else{
            NSLog("invalid score")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    //set text of row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init()
        }
        var setText = (String(names[Int(indexPath.row)]))
        setText.append("    ")
        setText.append(String(scores[Int(indexPath.row)]))
        cell?.textLabel?.text = setText
        return cell!
    }
    
    func addToLeaderboard(n: String, s: Int){
        //get the correct index and insert
        let i = findIndex(num: s)
        names.insert(n, at: i)
        scores.insert(String(s), at: i)
            
        //    reloadScreen()
        tableView.reloadData()
        }
    
    func findIndex(num: Int) -> Int{
        //num is the score we want to insert
        var index = 0
        while((index < scores.count) && (Int(scores[index])! >= num)){
            index += 1
        }
        NSLog("index to insert is ", index)
        return index;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "leaderToMain"){
            let mainVC: UIViewController = segue.destination 

        }
    }
    
    //only for editing?
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            names.remove(at: indexPath.row)
//            scores.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
////            reloadScreen()
//            }
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
