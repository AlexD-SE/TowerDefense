//
//  Enums.swift
//  TD
//
//  Created by Alex Demerjian on 3/22/24.
//

import Foundation
import SpriteKit

public enum TowerType: String{
    case spikeCannon = "SpikeCannon"
    case timeManipulator = "TimeManipulator"
    case boltStriker = "BoltStriker"
}

public enum mapEnemyPath{
    case map1
    
    public var rawValue: CGPath{
        
        switch self{
            
        case .map1:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: -161.36, y: 529.72))
            
            path.addCurve(to: CGPoint(x: -55.90, y: 279.32), control1: CGPoint(x: -31.94, y: 445.86), control2: CGPoint(x: -155.53, y: 367.22))
            path.addCurve(to: CGPoint(x: -89.21, y: -58.19), control1: CGPoint(x: -250.62, y: 128.35), control2: CGPoint(x: -146.8, y: 98))
            path.addCurve(to: CGPoint(x: 264.60, y: -390.41), control1: CGPoint(x: 34.62, y: -121.13), control2: CGPoint(x: 78.34, y: -241.85))
            path.addLine(to: CGPoint(x: 164.75, y: -530.93))
            
            return path
        }
        
        
        
    }
}
