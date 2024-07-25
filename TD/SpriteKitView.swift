//
//  SpriteKitView.swift
//  TD
//
//  Created by Alex Demerjian on 3/21/24.
//

import Foundation
import SwiftUI
import SpriteKit

struct SpriteKitView: NSViewRepresentable{

    let scene: SKScene
    
    typealias NSViewType = SKView
    
    func makeNSView(context: Context) -> SKView {
        
        let view = SKView()
        scene.scaleMode = .fill
        view.presentScene(scene)
        
        return view
    }
    
    func updateNSView(_ nsView: SKView, context: Context) {
        
    }
    
    func newTower(of type: TowerType, at position: CGPoint){
        
        //prepare new node on global thread
        DispatchQueue.global(qos: .userInitiated).async{
            
            let node = SKSpriteNode(imageNamed: type.rawValue)
            
            
            node.position = position
            
            //if the node is placed on the left side of the scene, flip it along the y-axis
            if position.x < 0{
                node.xScale *= -1
            }
            
            //setup physics body around tower so that it recognizes when an enemy comes within its range
            var sensorRadius: CGFloat = 50 // Adjust based on your game's needs
            
            switch type{
            case .spikeCannon: sensorRadius = 100
            case .timeManipulator: sensorRadius = 150
            case .boltStriker: sensorRadius = 300
            }
            
        }
        
    }
    
    
    func spawnEnemies(numOfEnemies: Int, interval: Double){
        
        for i in 0..<numOfEnemies{
            let delay = Double(i) * interval // 2 seconds apart
            let spawnAction = SKAction.sequence([
                SKAction.wait(forDuration: delay),
                SKAction.run(spawnEnemy)
            ])
            
            scene.run(spawnAction)
            
        }
        
    }
    
    
    func spawnEnemy() {
        
        let enemy = SKSpriteNode(color: .red, size: CGSize(width: 40, height: 40))
        
        let followPath = SKAction.follow(mapEnemyPath.map1.rawValue, asOffset: false, orientToPath: true, duration: 5.0)
        let sequence = SKAction.sequence([followPath, SKAction.removeFromParent()])
        
        enemy.run(sequence)
        scene.addChild(enemy)
        
    }
    
}
