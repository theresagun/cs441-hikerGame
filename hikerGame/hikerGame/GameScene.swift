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
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var content = false
    //motion manager for tilting the device
    let motionManager = CMMotionManager()

    
    //trees begin moving to the right TODO delete
    var invaderMovementDirection: InvaderMovementDirection = .right
    //trees didn't move yet so time == 0
    var timeOfLastMove: CFTimeInterval = 0.0
    //trees take one second per move
    let timePerMove: CFTimeInterval = 0.5

    enum treeType {
        case live
        case dead
        static var size: CGSize {
            return CGSize(width: 50, height: 50)
        }
        static var name: String {
            return "Tree"
        }
    }

    let kHikerSize = CGSize(width: 50, height: 50)
    let kHikerName = "hiker"
    
    let kScoreName = "scoreLabel"
    let kHealthName = "healthLabel"

    enum InvaderMovementDirection {
      case right
      case left
      case downThenRight
      case downThenLeft
      case none
    }

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
        //add a tree
       // let tree = SKSpriteNode(imageNamed: "deadTree.png")
//        let tree = SKSpriteNode(color: SKColor.purple, size: CGSize.init(width: 50, height: 50))
//        tree.position = CGPoint(x: 0, y: 0) //TODO maybe change this?
//        self.addChild(tree)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

        createTrees()
        placeHiker()
        setupLabels()

        //make background a forest (set to image later??)
        self.backgroundColor = SKColor.brown
    }
    
    func makeTree(ofType tType: treeType) -> SKNode {
      // use the type to determine color -- TODO will probably use this to determine damage?
//      var treeColor: SKColor //probably don't need?
//
//      switch(tType) {
//      case .a:
//        treeColor = SKColor.red
//      case .b:
//        treeColor = SKColor.purple
//      }
      
      // create a sprite (begins as a rectangle of specified color)
        let tree = SKSpriteNode(color: SKColor.green, size: GameScene.treeType.size)
        //let tree = SKSpriteNode(imageNamed: "x")
        tree.name = GameScene.treeType.name
      
      return tree
    }

    func createTrees() {
      //decide base origin, which is where to start spawning TODO move this to be global?
        self.viewTop = CGPoint(x:scene!.view!.center.x,y:scene!.view!.frame.minY)
        self.sceneTop = scene!.view!.convert(viewTop, to:scene!)
        self.nodeTop = scene!.convert(sceneTop,to:GameScene())
        
        let viewCorner = CGPoint(x:scene!.view!.frame.minX,y:scene!.view!.frame.minY)
        let sceneCorner = scene!.view!.convert(viewCorner, to:scene!)
        let nodeCorner = scene!.convert(sceneCorner,to:GameScene())
        
        let viewCorner2 = CGPoint(x:scene!.view!.frame.maxX,y:scene!.view!.frame.minY)
        let sceneCorner2 = scene!.view!.convert(viewCorner2, to:scene!)
        let nodeCorner2 = scene!.convert(sceneCorner2,to:GameScene())
        
        let baseOrigin = CGPoint(x: nodeCorner.x, y: self.nodeTop.y)
        
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
            //TODO the trees will only generate on one side of the screen?
            //place tree randomly along x axis at top of screen
            let rand = Int.random(in: Int(nodeCorner.x) ... Int(nodeCorner2.x))
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
      let hiker = SKSpriteNode(color: SKColor.black, size: kHikerSize)
      hiker.name = kHikerName
        //make a physics body the size of the hiker
        hiker.physicsBody = SKPhysicsBody(rectangleOf: hiker.frame.size)
        //dynamic makes collisions and other things possible
        hiker.physicsBody!.isDynamic = true
        //not affected by gravity so it doesn't change in y value
        hiker.physicsBody!.affectedByGravity = false
        //arbitrary mass so its movement is more natural
        hiker.physicsBody!.mass = 0.02
      return hiker
    }
    
    func setupLabels() {
//        let viewTop = CGPoint(x:scene!.view!.center.x,y:scene!.view!.frame.minY)
//        let sceneTop = scene!.view!.convert(viewTop, to:scene!)
//        let nodeTop = scene!.convert(sceneTop,to:GameScene())
      //create score label TODO maybe score is time survived?
      let scoreLabel = SKLabelNode(fontNamed: "Courier")
      scoreLabel.name = kScoreName
      scoreLabel.fontSize = 25
      scoreLabel.fontColor = SKColor.white
      scoreLabel.text = String(format: "Score: %04u", 0)
        scoreLabel.position = CGPoint(x: self.nodeTop.x + 150, y: self.nodeTop.y-100)
      addChild(scoreLabel)
      
      //same for health TODO change health to hearts not %
      let healthLabel = SKLabelNode(fontNamed: "Courier")
      healthLabel.name = kHealthName
      healthLabel.fontSize = 25
      healthLabel.fontColor = SKColor.white
      healthLabel.text = String(format: "Health: %.1f%%", 100.0)
        healthLabel.position = CGPoint(x: self.nodeTop.x - 150, y: self.nodeTop.y-100)
      addChild(healthLabel)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        processUserMotion(forUpdate: currentTime)
        var toRemove = [SKNode]()
        var didCreate = false
        //loop through trees TODO make normal loop
        enumerateChildNodes(withName: treeType.name) { node, stop in
          switch self.invaderMovementDirection {
          default:
              //always moving down, TODO this shouldn't be a switch statement
            if(node.position.y == self.nodeTop.y - 300 && !didCreate){
                self.createTrees()
                didCreate = true
            }
            else if(node.position.y <= self.nodeBottom.y){
                //end of screen so remove node
                node.removeFromParent()
            }
            node.position = CGPoint(x: node.position.x, y: node.position.y - 10)
          }
          //update move time
          self.timeOfLastMove = currentTime
        }
        moveTrees(forUpdate: currentTime)
    }
    
    func moveTrees(forUpdate currentTime: CFTimeInterval) {
      //is it time to move?
      if (currentTime - timeOfLastMove < timePerMove) {
        return
      }
      
      //loop through trees
      enumerateChildNodes(withName: treeType.name) { node, stop in
        switch self.invaderMovementDirection {
        default:
            //always moving down, TODO this shouldn't be a switch statement
            node.position = CGPoint(x: node.position.x, y: node.position.y - 10)
        }
        
        //update move time
        self.timeOfLastMove = currentTime
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
            hiker.physicsBody!.applyForce(CGVector(dx: 40 * CGFloat(data.acceleration.x), dy: 0))
          }
        }
      }
    }


}
