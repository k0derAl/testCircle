//
//  GameScene.swift
//  test
//
//  Created by Александр on 23.06.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let redCircle = SKShapeNode()
    let greenCircle = SKShapeNode()
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        view.showsPhysics = true
        
        greenCircle.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        greenCircle.position = CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.maxY - 200)
        greenCircle.fillColor = UIColor.green
        greenCircle.strokeColor = UIColor.green
        
        greenCircle.physicsBody = SKPhysicsBody(circleOfRadius: greenCircle.frame.width / 2, center: CGPoint(x: 22.5, y: 22.5))
        greenCircle.physicsBody?.categoryBitMask = CollisionCategories.greenCircle
        greenCircle.physicsBody?.contactTestBitMask = CollisionCategories.redCircle
        
        self.addChild(greenCircle)
        
        redCircle.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        redCircle.position = CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.minY + 100)
        redCircle.fillColor = UIColor.red
        redCircle.strokeColor = UIColor.red
        
        redCircle.physicsBody = SKPhysicsBody(circleOfRadius: redCircle.frame.width / 2, center: CGPoint(x: 22.5, y: 22.5))
        redCircle.physicsBody?.categoryBitMask = CollisionCategories.redCircle
        redCircle.physicsBody?.contactTestBitMask = CollisionCategories.greenCircle
        self.addChild(redCircle)
        
        self.physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nextPosition = CGPoint(x: redCircle.position.x, y: redCircle.position.y)
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        greenCircle.run(moveAction)
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
    struct CollisionCategories {
        static let greenCircle: UInt32 = 0x1 << 0
        static let redCircle: UInt32 = 0x1 << 1
    }
}
