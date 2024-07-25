//
//  MainViewModel.swift
//  TD
//
//  Created by Alex Demerjian on 3/22/24.
//

import Foundation
import SpriteKit
import SwiftUI

public class MainViewModel: ObservableObject{
    
    var currentNewTower: TowerSKSpriteNode! = nil
    @Published var spriteKitView: SpriteKitView! = nil
    @Published var spriteKitViewGP: GeometryProxy! = nil
    @Published var spikeCannonThumbnailGP: GeometryProxy! = nil
    @Published var timeManipulatorThumbnailGP: GeometryProxy! = nil
    @Published var boltStrikerThumbnailGP: GeometryProxy! = nil

    public func updatePositionOfNewTower(of towerType: TowerType, to tappedPoint: CGPoint){
        
        Task.detached(priority: .userInitiated){
            
            let spriteKitViewPosition = self.getSpriteKitViewPosition(for: towerType, at: tappedPoint)
            
            if let currentNewTower = self.currentNewTower{
                
                await MainActor.run{
                    currentNewTower.position = spriteKitViewPosition
                }
                
            }else{
                
                await self.currentNewTower = TowerSKSpriteNode(towerType: towerType)
                
                await MainActor.run{
                    self.currentNewTower.position = spriteKitViewPosition
                }
                
                await self.spriteKitView.scene.addChild(self.currentNewTower)
            }
            
            
        
        }
        
    }
    
    public func finalizePositionOfNewTower(of towerType: TowerType, to tappedPoint: CGPoint){
        
        Task.detached(priority: .userInitiated){
            
            //perform taxing operations
            let spriteKitViewPosition = self.getSpriteKitViewPosition(for: towerType, at: tappedPoint)
            self.currentNewTower = await TowerSKSpriteNode(towerType: towerType)
            
            //run UI updates on main actor
            await MainActor.run{
                    
                self.currentNewTower.position = spriteKitViewPosition
                self.spriteKitView.scene.addChild(self.currentNewTower)
                //self.currentNewTower.hideDetectionFieldVisual()
            }
                
            self.currentNewTower = nil
            
        }
        
    }
    
    private func getSpriteKitViewPosition(for type: TowerType, at tappedPoint: CGPoint) -> CGPoint{
        
        //get the spritekitview's size in the window
        let spriteKitViewSize = spriteKitViewGP.frame(in: .global).size
        
        //get the actual spritekitview's size
        let actualSpriteKitViewSize = spriteKitView.scene.size
        
        //get the position of the tower thumbnail relative to the global view
        var towerThumbnailGlobalPosition = CGPoint.zero
        
        //get the position tapped relative to the whole window instance (factor in the origin of the
        switch type{
        case .spikeCannon:
            towerThumbnailGlobalPosition = spikeCannonThumbnailGP.frame(in: .global).origin
        case .timeManipulator:
            towerThumbnailGlobalPosition = timeManipulatorThumbnailGP.frame(in: .global).origin
        case .boltStriker:
            towerThumbnailGlobalPosition = boltStrikerThumbnailGP.frame(in: .global).origin
        }
        
        let gestureEndGlobalPosition = CGPoint(x: towerThumbnailGlobalPosition.x + tappedPoint.x, y: towerThumbnailGlobalPosition.y + tappedPoint.y)
        
        let nonScaledSpriteKitViewPosition = CGPoint(x: -((spriteKitViewSize.width/2) - gestureEndGlobalPosition.x), y: (spriteKitViewSize.height/2) - gestureEndGlobalPosition.y)
        
        // figure out the scaling factor for the actual size of the spritekitview compared to the size of the displayed spritekitview
        let spriteScaleFactorX = actualSpriteKitViewSize.width/spriteKitViewSize.width
        let spriteScaleFactorY = actualSpriteKitViewSize.height/spriteKitViewSize.height
        
        let spriteKitViewPosition = CGPoint(x: nonScaledSpriteKitViewPosition.x * spriteScaleFactorX, y: nonScaledSpriteKitViewPosition.y * spriteScaleFactorY)
        
        return spriteKitViewPosition
        
    }
    
    
    
}
