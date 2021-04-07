//
//  PreplayViewController.swift
//  hikerGame
//
//  Created by Theresa Gundel on 3/31/21.
//

import UIKit



class PreplayViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var hiker1: UIButton!
    @IBOutlet var hiker2: UIButton!
    @IBOutlet var hiker3: UIButton!
    @IBOutlet var hiker4: UIButton!
    
    var hikerChoice: String!
    var name: String!
    
    var names: [String]?
    var scores: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        // Do any additional setup after loading the view.
        //defaults
        hikerChoice = "Hiker1"
        name = "Anonymous"
        self.nameField.delegate = self
    }
    
    @IBAction func clickedButton1(button: UIButton){
        hikerChoice = "Hiker1"
    }
    
    @IBAction func clickedButton2(button: UIButton){
        hikerChoice = "Hiker2-1"
    }
    
    @IBAction func clickedButton3(button: UIButton){
        hikerChoice = "Hiker3size"
    }
    
    @IBAction func clickedButton4(button: UIButton){
        hikerChoice = "Hiker4size"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textfield: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
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
        if(segue.identifier == "preplayToGame"){
            let gvc: GameViewController = segue.destination as! GameViewController
            gvc.hikerImageName = hikerChoice
            gvc.playerName = nameField.text
            gvc.names = self.names ?? []
            gvc.scores = self.scores ?? []
        }
    }
    
}
