//
//  TrailDataManager.swift
//  MyAppIntents
//
//  Created by 童星 on 2024/10/28.
//

import Foundation
import CoreLocation
import Observation

@Observable class TrailDataManager: @unchecked Sendable {
    
    static let shared = TrailDataManager()

    let trails: [TrailEntity]

    private init() {
        trails = [
            TrailEntity(id: "1", name: "爬山路径", trailStyle: .mountaineering),
            TrailEntity(id: "2", name: "海滩路径", trailStyle: .beach),
            TrailEntity(id: "3", name: "骑行路径", trailStyle: .biking)
        ]
    }
}

extension TrailDataManager {
    
    func trail(with identifier: TrailEntity.ID) -> TrailEntity? {
        return trails.first { $0.id == identifier }
    }
}
