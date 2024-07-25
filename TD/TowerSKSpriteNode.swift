//
//  TowerSKSpriteNode.swift
//  TD
//
//  Created by Alex Demerjian on 3/23/24.
//

import Foundation
import SpriteKit

public class TowerSKSpriteNode: SKSpriteNode{
    
    public init(towerType: TowerType){
        
        var size = CGSize.zero
        var detectionFieldRadius = 0.0
        
        switch towerType{
        case .spikeCannon: 
            size = CGSize(width: 100, height: 100)
            detectionFieldRadius = 100
        case .timeManipulator:
            size = CGSize(width: 75, height: 125)
            detectionFieldRadius = 100
        case .boltStriker:
            size = CGSize(width: 75, height: 125)
            detectionFieldRadius = 300
        }
        
        let texture = SKTexture(imageNamed: towerType.rawValue)
        
        let detectionFieldBody = SKPhysicsBody(circleOfRadius: detectionFieldRadius)
        detectionFieldBody.isDynamic = false // Doesn't move
        detectionFieldBody.categoryBitMask = PhysicsCategory.towerSensor
        detectionFieldBody.contactTestBitMask = PhysicsCategory.enemy
        detectionFieldBody.collisionBitMask = PhysicsCategory.none
        
        let detectionFieldVisual = SKShapeNode(circleOfRadius: detectionFieldRadius)
        detectionFieldVisual.position = CGPoint(x: 0, y: 0)
        detectionFieldVisual.strokeColor = SKColor.gray
        detectionFieldVisual.fillColor = SKColor.gray
        detectionFieldVisual.alpha = 0.25
        detectionFieldVisual.lineWidth = 3
        
        super.init(texture: texture, color: .clear, size: size)
        super.physicsBody = detectionFieldBody
        
        DispatchQueue.main.async{
            super.addChild(detectionFieldVisual)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showDetectionFieldVisual(){
        super.children[0].isHidden = false
    }
    
    func hideDetectionFieldVisual(){
        super.children[0].isHidden = true
    }
    
}
