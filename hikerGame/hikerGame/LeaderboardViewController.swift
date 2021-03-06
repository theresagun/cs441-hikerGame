//
//  LeaderboardViewController.swift
//  hikerGame
//
//  Created by Theresa Gundel on 3/31/21.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet var tableView: UITableView!
    @IBOutlet var resetButton: UIButton!
    var names: [String] = []
    var scores: [String] = []

    var playerName: String?
    var totalScore: Int?
    
    var reset = false

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        if let score = self.totalScore{
            if let name = self.playerName{
                addToLeaderboard(n: name, s: score)
            }
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
        tableView.reloadData()
        }
    
    func findIndex(num: Int) -> Int{
        //num is the score we want to insert
        var index = 0
        while((index < scores.count) && (Int(scores[index])! >= num)){
            index += 1
        }
        return index;
    }
    
    @IBAction func clickReset(button: UIButton){
        self.names = []
        self.scores = []
        tableView.reloadData()
        self.reset = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "leaderToMain"){
            //TODO working on storing names and scores in app while it's on
            let mainVC: ViewController = segue.destination as! ViewController
            mainVC.names = self.names
            mainVC.scores = self.scores
//            mainVC.openDatabse()
            if self.reset {
                mainVC.needsReset = true
            }
            mainVC.firstTime = false
            if let score = self.totalScore{
                if let name = self.playerName{
                    mainVC.nameToStore = name
                    mainVC.scoreToStore = String(score)
                }
            }
                
            }
    }

}
