//
//  PhysicsCategory.swift
//  TD
//
//  Created by Alex Demerjian on 3/23/24.
//

import Foundation

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let enemy: UInt32 = 0x1 << 0
    static let towerSensor: UInt32 = 0x1 << 1
}
