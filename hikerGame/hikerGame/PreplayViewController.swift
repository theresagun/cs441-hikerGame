//
//  PreplayViewController.swift
//  hikerGame
//
//  Created by Theresa Gundel on 3/31/21.
//

import UIKit



class PreplayViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var hiker1: UIButton!
    @IBOutlet var hiker2: UIButton!
    @IBOutlet var hiker3: UIButton!
    @IBOutlet var hiker4: UIButton!
    
    var hikerChoice: String!
    var name: String!
    
//    var leader: LeaderboardViewController?
    var names: [String]?
    var scores: [String]?
    
    //weak var iDelegate: imageDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //defaults
        hikerChoice = "x"
        name = "Anonymous"
    }
    
    @IBAction func clickedButton1(button: UIButton){
        print("clicked hiker1 button")
        //chose hiker image 1
        hikerChoice = "hikerResize"
    }
    
    @IBAction func clickedButton2(button: UIButton){
        print("clicked hiker2 button")
        //chose hiker image 1
        hikerChoice = "hiker2"
    }
    
    @IBAction func clickedButton3(button: UIButton){
        print("clicked hiker3 button")
        //chose hiker image 1
        hikerChoice = "hiker3"
    }
    
    @IBAction func clickedButton4(button: UIButton){
        print("clicked hiker4 button")
        //chose hiker image 1
        hikerChoice = "hiker4"
    }
    
//    //delegate method
//    func getImageName() {
//        NSLog("idk what to put here")
//    }
    
//    @IBAction func clickedPlay(button: UIButton){
//        var nextVC = GameViewController()
//        navigationController?.pushViewController(nextVC,
//              animated: false)
//
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // print("name is ", nameField.text)
        if(segue.identifier == "preplayToGame"){
            let gvc: GameViewController = segue.destination as! GameViewController
            gvc.hikerImageName = hikerChoice
            gvc.playerName = nameField.text
//            gvc.leader = self.leader
            gvc.names = self.names ?? []
            gvc.scores = self.scores ?? []
            //    gvc.iDelegate = self
            
        }
//        if let nav = segue.destination as? UINavigationController, let gvc = nav.topViewController as? GameViewController {
//            gvc.nDelegate = self
//        }
    }
    //    prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //        if([segue.identifier isEqualToString:@"mainToXerox"]){
    //            NSLog(@"xerox");
    //            SecondViewController *destinationVc = segue.destinationViewController;
    //            Connector *connectorClass = [[Connector alloc] init];
    //            connectorClass.isXerox = isXerox;
    //            destinationVc.connectorClass = connectorClass;
    //        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
