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
    
   let motionManager = CMMotionManager()

    
    var content = false
    // 1
    var invaderMovementDirection: InvaderMovementDirection = .right
    // 2
    var timeOfLastMove: CFTimeInterval = 0.0
    // 3
    let timePerMove: CFTimeInterval = 1.0

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
    
    //how trees will be laid out (in a grid) TODO change this to say tree, or just remove if not needed
    let kInvaderGridSpacing = CGSize(width: 12, height: 12)
    let kInvaderRowCount = 6
    let kInvaderColCount = 6

    let kShipSize = CGSize(width: 50, height: 50)
    let kShipName = "ship"
    
    let kScoreHudName = "scoreHud"
    let kHealthHudName = "healthHud"

    enum InvaderMovementDirection {
      case right
      case left
      case downThenRight
      case downThenLeft
      case none
    }

    

    override func didMove(to view: SKView) {
        
        if(!content){
            contentOnScreen()
            content = true
            motionManager.startAccelerometerUpdates()

        }
        
        //following is default from game tempplate
//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
    }
    
    func contentOnScreen(){
        //add a tree
       // let tree = SKSpriteNode(imageNamed: "deadTree.png")
//        let tree = SKSpriteNode(color: SKColor.purple, size: CGSize.init(width: 50, height: 50))
//        tree.position = CGPoint(x: 0, y: 0) //TODO maybe change this?
//        self.addChild(tree)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

        setupTrees()
        setupShip()
        setupHud()

        //make background a forest (set to image later??)
        self.backgroundColor = SKColor.green
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
        let tree = SKSpriteNode(color: SKColor.red, size: GameScene.treeType.size)
        //let tree = SKSpriteNode(imageNamed: "x")
        
        tree.name = GameScene.treeType.name
      
      return tree
    }

    //lay out trees in a grid
    //rows % 3 are type a
    func setupTrees() {
      //decide base origin, which is where to start spawning
        let baseOrigin = CGPoint(x: 0, y: 0)
      for row in 0..<kInvaderRowCount {
        //give tree types based on row
        var tType: treeType
        
        if row % 3 == 0 {
          tType = .live
        } else {
          tType = .dead
        }
        
        //position of first tree in this row
        let invaderPositionY = CGFloat(row) * (GameScene.treeType.size.height * 2) + baseOrigin.y
        
        var invaderPosition = CGPoint(x: baseOrigin.x, y: invaderPositionY)
        
        //
        for _ in 1..<kInvaderColCount {
          //for each row/col create a tree and add to scene
          let tree = makeTree(ofType: tType)
          tree.position = invaderPosition
          
          addChild(tree)
          //update for the next tree
          invaderPosition = CGPoint(
            x: invaderPosition.x + GameScene.treeType.size.width + kInvaderGridSpacing.width,
            y: invaderPositionY
          )
        }
      }
    }

    func setupShip() {
      //create a hiker
      let ship = makeShip()
      
      //put the hiker on the screen
        ship.position = CGPoint(x: -10, y: -10)
      addChild(ship)
    }

    func makeShip() -> SKNode {
      let ship = SKSpriteNode(color: SKColor.black, size: kShipSize)
      ship.name = kShipName
        
        // 1
        ship.physicsBody = SKPhysicsBody(rectangleOf: ship.frame.size)

        // 2
        ship.physicsBody!.isDynamic = true

        // 3
        ship.physicsBody!.affectedByGravity = false

        // 4
        ship.physicsBody!.mass = 0.02

      return ship
    }
    
    func setupHud() {
      //create score label TODO maybe score is time survived?
      let scoreLabel = SKLabelNode(fontNamed: "Courier")
      scoreLabel.name = kScoreHudName
      scoreLabel.fontSize = 25
      scoreLabel.fontColor = SKColor.white
      scoreLabel.text = String(format: "Score: %04u", 0)
      scoreLabel.position = CGPoint(x: 50, y: 50)
      addChild(scoreLabel)
      
      //same for health
      let healthLabel = SKLabelNode(fontNamed: "Courier")
      healthLabel.name = kHealthHudName
      healthLabel.fontSize = 25
      healthLabel.fontColor = SKColor.purple
      healthLabel.text = String(format: "Health: %.1f%%", 100.0)
      healthLabel.position = CGPoint(
        x: frame.size.width / 2,
        y: size.height - (80 + healthLabel.frame.size.height/2)
      )
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        processUserMotion(forUpdate: currentTime)

        moveInvaders(forUpdate: currentTime)

    }
    
    func moveInvaders(forUpdate currentTime: CFTimeInterval) {
      // 1
      if (currentTime - timeOfLastMove < timePerMove) {
        return
      }
      
      // 2
      enumerateChildNodes(withName: treeType.name) { node, stop in
        switch self.invaderMovementDirection {
        case .right:
          node.position = CGPoint(x: node.position.x + 10, y: node.position.y)
        case .left:
          node.position = CGPoint(x: node.position.x - 10, y: node.position.y)
        case .downThenLeft, .downThenRight:
          node.position = CGPoint(x: node.position.x, y: node.position.y - 10)
        case .none:
          break
        }
        
        // 3
        self.timeOfLastMove = currentTime
      }
    }
    
    func processUserMotion(forUpdate currentTime: CFTimeInterval) {
      // 1
      if let ship = childNode(withName: kShipName) as? SKSpriteNode {
        // 2
        if let data = motionManager.accelerometerData {
          // 3
          if fabs(data.acceleration.x) > 0.2 {
            // 4 How do you move the ship?
            ship.physicsBody!.applyForce(CGVector(dx: 40 * CGFloat(data.acceleration.x), dy: 0))
          }
        }
      }
    }


}
