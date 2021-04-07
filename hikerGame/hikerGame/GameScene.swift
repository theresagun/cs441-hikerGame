//
//  GameScene.swift
//  hikerGame
//
//  Created by Theresa Gundel on 3/24/21.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    var viewController: UIViewController?
    //keep track of score & health at top in labels
    var scoreLabel: SKLabelNode!
    var healthLabel: SKLabelNode!
    var highscoreLabel: SKLabelNode!
    
    var score = 0
    var healthTracker = 5
    
    var content = false
    //motion manager for tilting the device
    let motionManager = CMMotionManager()
    //y value at which we generate more trees
    var generationPoint = 500
    //speed
    var treeSpeed = 5
    //tree info
    enum treeType {
        case live
        case dead
        static var t1: Bool {
            return true
        }
        static var t2: Bool {
            return false
        }
        static var size: CGSize {
            return CGSize(width: 50, height: 50)
        }
        static var name: String {
            return "Tree"
        }
    }
    //hiker infor
    let kHikerName = "hiker"
    //finding top and bottom of screen
    var viewTop: CGPoint!
    var nodeTop: CGPoint!
    var sceneTop: CGPoint!
    var viewBottom: CGPoint!
    var nodeBottom: CGPoint!
    var sceneBottom: CGPoint!

    override func didMove(to view: SKView) {
        if(!content){
            contentOnScreen()
            content = true
            motionManager.startAccelerometerUpdates()
        }
    }
    
    func contentOnScreen(){
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        createTrees()
        placeHiker()
        setupLabels()
        //make background a forest (set to image later??)
        self.backgroundColor = SKColor.brown
    }
    
    func makeTree(ofType tType: treeType) -> SKNode {
      // create a sprite (begins as a rectangle of specified color)
        var treeImage = "liveResize"
        switch tType {
        case .dead:
            treeImage = "deadTREE-1"
        case .live:
            treeImage = "liveResize"
        }
        let tree = SKSpriteNode(imageNamed: treeImage)
        tree.userData = NSMutableDictionary()
        switch tType { //store if live or dead in the node
        case .live:
            tree.userData?.setValue(GameScene.treeType.t1, forKeyPath: "type")
        case .dead:
            tree.userData?.setValue(GameScene.treeType.t2, forKeyPath: "type")
        }
        tree.name = GameScene.treeType.name
      
      return tree
    }

    func createTrees() {
        //decide base origin, which is where to start spawning
        self.viewTop = CGPoint(x:scene!.view!.center.x,y:scene!.view!.frame.minY)
        self.sceneTop = scene!.view!.convert(viewTop, to:scene!)
        self.nodeTop = scene!.convert(sceneTop,to:GameScene())

        let baseOrigin = CGPoint(x: CGFloat(0), y: self.nodeTop.y)
        
        var tType: treeType
        
        //random num of trees every time they generate
        let numTrees = Int.random(in: 1..<5)
        for _ in 1 ... numTrees {
            //randomly decide type of tree
            if Bool.random(){
                tType = .live
            }
            else{
                tType = .dead
            }
            //place tree randomly along x axis at top of screen
            let rand = Int.random(in: (0-Int(self.nodeTop.x)) ... (2*Int(self.nodeTop.x)))
            let treePosition = CGPoint(x: baseOrigin.x + CGFloat(rand), y: baseOrigin.y)
          let tree = makeTree(ofType: tType)
          tree.position = treePosition
          addChild(tree)
        }
    }

    func placeHiker() {
      //create a hiker
      let hiker = makeHiker()
        //get the x,y values for the bottom center of the screen
        self.viewBottom = CGPoint(x:scene!.view!.center.x,y:scene!.view!.frame.maxY)
        self.sceneBottom = scene!.view!.convert(self.viewBottom, to:scene!)
        self.nodeBottom = scene!.convert(self.sceneBottom,to:GameScene())
        //put the hiker here ish
        hiker.position = CGPoint(x: self.nodeBottom.x, y: self.nodeBottom.y + 50)
      addChild(hiker)
        
    }

    func makeHiker() -> SKNode {
        let hikerImName = (self.viewController as! GameViewController).hikerImageName!
        let hiker = SKSpriteNode(imageNamed: hikerImName)
        hiker.name = kHikerName
        //make a physics body the size of the hiker
        hiker.physicsBody = SKPhysicsBody(rectangleOf: hiker.frame.size)
        //dynamic makes collisions and other things possible
        hiker.physicsBody!.isDynamic = true
        //not affected by gravity so it doesn't change in y value
        hiker.physicsBody!.affectedByGravity = false
        //arbitrary mass so its movement is more natural TODO maybe change this to fix movement
        hiker.physicsBody!.mass = 0.02
      return hiker
    }
    
    func setupLabels() {
      //create score label
        self.scoreLabel = SKLabelNode(fontNamed: "Courier")
        self.scoreLabel.name = "scoreLabel"
        self.scoreLabel.fontSize = 25
        self.scoreLabel.fontColor = SKColor.white
        self.scoreLabel.text = String(format: "Score: %04u", 0)
        self.scoreLabel.position = CGPoint(x: self.nodeTop.x + 150, y: self.nodeTop.y-100)
      addChild(scoreLabel)

      //same for health TODO change health to hearts not %
        self.healthLabel = SKLabelNode(fontNamed: "Courier")
        self.healthLabel.name = "healthLabel"
        self.healthLabel.fontSize = 25
        self.healthLabel.fontColor = SKColor.white
        self.healthLabel.text = String(format: "Health:")
        self.healthLabel.position = CGPoint(x: self.nodeTop.x - 150, y: self.nodeTop.y-100)
      addChild(healthLabel)
        
        for i in 1...5 {
            let heart = SKSpriteNode(imageNamed: "pixelheart")
            heart.position = CGPoint(x: self.nodeTop.x - CGFloat((50 + (5-i)*51)), y: self.nodeTop.y-130)
            heart.name = "heart" + String(i)
            addChild(heart)
        }
        
        //create HIGHscore label
          self.highscoreLabel = SKLabelNode(fontNamed: "Courier")
          self.highscoreLabel.name = "highscoreLabel"
          self.highscoreLabel.fontSize = 25
          self.highscoreLabel.fontColor = SKColor.white
        if let scoreList = (self.viewController as! GameViewController).scores{
            if scoreList.count > 0{
                self.highscoreLabel.text = "Highscore: " + scoreList[0]
            }
            else{
                self.highscoreLabel.text = "Highscore: 0"

            }
        }
        else{
            self.highscoreLabel.text = "Highscore: 0"

        }
        
          self.highscoreLabel.position = CGPoint(x: self.nodeTop.x + 150, y: self.nodeTop.y-130)
        addChild(highscoreLabel)
    }
    
    func updateLabels(){
        self.scoreLabel.text = String(format: "Score: %04u", self.score)
//        self.healthLabel.text = String(format: "Health: %04u", self.healthTracker)
    }
    
    func removeHeart(num: Int){
        self.healthTracker -= 1
        enumerateChildNodes(withName: "heart" + String(num)) { (node: SKNode, nil) in
            true; do {
                node.removeFromParent()
            }
            
        }
    }
    
    func checkForCollisions(){
        enumerateChildNodes(withName: treeType.name){ (node: SKNode, nil) in
            if(node.intersects(self.childNode(withName: self.kHikerName)!)){
                //if it intersects
                node.removeFromParent()
                if let type = node.userData?.value(forKey: "type"){
                    if type as! Bool == GameScene.treeType.t1 {
                        //live tree
                        self.removeHeart(num: self.healthTracker)
                        self.removeHeart(num: self.healthTracker)
                        return
                    }
                    else{
                        //dead tree
                        self.removeHeart(num: self.healthTracker)
                        return
                    }
                }
            }
          }
        }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        processUserMotion(forUpdate: currentTime)
        checkForCollisions()
        
        var didCreate = false
        var gotPoints = false
        //loop through trees
        enumerateChildNodes(withName: treeType.name) { (node: SKNode, nil) in
            true; do {
          //      if(node.position.y > self.nodeTop.y - CGFloat(self.generationPoint) - CGFloat(self.treeSpeed) && node.position.y < self.nodeTop.y - CGFloat(self.generationPoint) + CGFloat(self.treeSpeed) && !didCreate){
                if(node.position.y == self.nodeTop.y - CGFloat(self.generationPoint) && !didCreate){
                self.createTrees()
                didCreate = true
            }
            else if(node.position.y <= self.nodeBottom.y){
                //end of screen so remove node
                node.removeFromParent()
                if(!gotPoints){
                    self.score += 1
                    gotPoints = true
//                    if self.score % 5 == 0 {
//                        self.treeSpeed += 1
//                    }
                    if self.score % 5 == 0 {
                        self.generationPoint -= 25
                    }
                }
            }
                
            node.position = CGPoint(x: node.position.x, y: node.position.y - CGFloat(self.treeSpeed))
          }
        }
        updateLabels()
        //if health <= 0 --> segue to leaderboard w/ score saved
        if(self.healthTracker <= 0){
            self.view?.isPaused = true
            //save the score between views
            (self.viewController as! GameViewController).score = self.score
            //go to leaderboard
            self.viewController?.performSegue(withIdentifier: "gameToLeaderboard", sender: self)
        }
    }

    func processUserMotion(forUpdate currentTime: CFTimeInterval) {
      //get the hiker
      if let hiker = childNode(withName: kHikerName) as? SKSpriteNode {
        //get accelerometer data
        if let data = motionManager.accelerometerData {
          //device is flat no matter the orientation
          if fabs(data.acceleration.x) > 0.2 {
            //move hiker with force from physics body x accelerometer, change the num 40 if it doesn't look right
            hiker.physicsBody!.applyForce(CGVector(dx: 30 * CGFloat(data.acceleration.x), dy: 0))
          }
        }
      }
    }

}
