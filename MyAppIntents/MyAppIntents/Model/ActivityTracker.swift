//
//  ActivityTracker.swift
//  MyAppIntents
//
//  Created by 童星 on 2024/10/25.
//

import Foundation
import AppIntents
import HealthKit
import Observation
import OSLog

@Observable class ActivityTracker {
    static let shared = ActivityTracker()
        
    private init() {}
    
    var trailEntitysSummary: TrailEntitysSummary {
        let stats = TrailEntitysSummary()
        let trail = TrailDataManager.shared.trails.first!
        stats.id = trail.id
        stats.name = trail.name + "我是总结内容"
        stats.style = trail.trailStyle
        
        return stats
    }
}
