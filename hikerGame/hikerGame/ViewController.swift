//
//  ViewController.swift
//  hikerGame
//
//  Created by Theresa Gundel on 3/31/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: Variables declearations
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context:NSManagedObjectContext!
    
    var names: [String]?
    var scores: [String]?
    var needsStoring: [Bool]?
    
    var nameToStore: String?
    var scoreToStore: String?
    
    var firstTime = true
    var needsReset = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        openDatabse()
        if self.firstTime{
            fetchData()
        }
    }
    
    // MARK: Methods to Open, Store and Fetch data
    func openDatabse()
    {
        context = appDelegate.persistentContainer.viewContext
        if self.needsReset{
            //context.
            NSLog("needs reset")
            resetAllRecords(in: "Entry")
        }
        if nameToStore != nil{
            if scoreToStore != nil{
                let entity = NSEntityDescription.entity(forEntityName: "Entry", in: context)
                let newUser = NSManagedObject(entity: entity!, insertInto: context)
                saveData(UserDBObj:newUser)
            }
        }
    }
    
    func resetAllRecords(in entity : String) // entity = Your_Entity_Name
        {

            let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            do
            {
                try context.execute(deleteRequest)
                try context.save()
            }
            catch
            {
                print ("There was an error")
            }
        }
    
    func saveData(UserDBObj:NSManagedObject)
     {

        UserDBObj.setValue(nameToStore, forKey: "name")
        UserDBObj.setValue(scoreToStore, forKey: "score")
        print("Storing Data..")
        do {
            try context.save()
        } catch {
            print("Storing data Failed")
        }
            
        
//        if let nList = self.names {
//            if let sList = self.scores {
//                var iter = 0
//                for n in nList{
//                    if needsStoring[iter] {
//                        print("storing ",n)
//                        if let s = self.scores?[iter]{
//                            print("with score ",s)
//                            UserDBObj.setValue(n, forKey: "name")
//                            UserDBObj.setValue(s, forKey: "score")
//                            iter += 1
//
//                            print("Storing Data..")
//                            do {
//                                try context.save()
//                            } catch {
//                                print("Storing data Failed")
//                            }
//                        }
//                    }
//                    else{
//                        print("already stored")
//                    }
//                }
//            }
//        }
     }

     func fetchData()
     {
         print("Fetching Data..")
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
         request.returnsObjectsAsFaults = false
         do {
            let result = try context.fetch(request)
            print("length of result is ",result.count)
            var iter1 = 0
             for data in result as! [NSManagedObject] {
                print(iter1)
                iter1 += 1
                let nameL = data.value(forKey: "name")
                let scoreL = data.value(forKey: "score")
                print("Retrieved: ",nameL,scoreL)

                if nameL == nil {
                    continue
                }
                if var scoreList = self.scores {
                    print("scores exists")
                    if var nameList = self.names{
                        print("names exists")
                        self.scores?.append(scoreL as! String)
                        self.names?.append(nameL as! String)
                    }
                }
                else{
                    self.names = [nameL as! String]
                    self.scores = [scoreL as! String]
                }
             }
         } catch {
             print("Fetching data Failed")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "mainToInstructions"){
            let instr: InstructionsViewController = segue.destination as! InstructionsViewController
            instr.names = self.names
            instr.scores = self.scores
        }
        else if(segue.identifier == "mainToPreplay"){
            let prep: PreplayViewController = segue.destination as! PreplayViewController
            prep.names = self.names
            prep.scores = self.scores
        }
        else if(segue.identifier == "mainToLeaderboard"){
            let lead: LeaderboardViewController = segue.destination as! LeaderboardViewController
            lead.names = self.names ?? []
            lead.scores = self.scores ?? []
        }
        
    }

}
