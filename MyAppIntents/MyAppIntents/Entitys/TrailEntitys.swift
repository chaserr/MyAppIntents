//
//  TrailEntitys.swift
//  MyAppIntents
//
//  Created by 童星 on 2024/10/24.
//

import Foundation
import SwiftUI
import AppIntents

struct TrailEntity: AppEntity {
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation {
      TypeDisplayRepresentation(
        name: LocalizedStringResource("TypeDisplay路径", table: "AppIntents"),
        numericFormat: LocalizedStringResource("\(placeholder: .int) TypeDisplay路径", table: "AppIntents")
      )
    }
    
    static var defaultQuery = TrailEntityQuery()

    var id: String
    
    @Property(title: "Trail Name")
    var name: String
    
    var trailStyle: TrailsStyle

    // 实现显示名称，供快捷方式界面展示
    var displayRepresentation: DisplayRepresentation {
    //        DisplayRepresentation(title: "\(name)")
        TrailsStyle.caseDisplayRepresentations[trailStyle] ?? "Unknown Trail Style"
    }
    
    // 实体查询器，提供供选择的路径列表
    struct TrailEntityQuery: EntityQuery {
        func entities(for identifiers: [String]) -> [TrailEntity] {
            TrailDataManager.shared.trails.filter { identifiers.contains($0.id) }
        }

        func suggestedEntities() -> [TrailEntity] {
            // 返回在提供此查询支持的选项列表时显示的初始结果。
            return TrailDataManager.shared.trails
        }
    }
    
    init(id: String, name: String, trailStyle: TrailsStyle) {
        self.trailStyle = trailStyle
        self.id = id
        self.name = name
    }
}

enum TrailsStyle: String, Codable, Sendable {
    case mountaineering = "爬山"
    case beach = "海滩"
    case biking = "骑行"
    
    var symbol: String {
        switch self {
        case .biking:
            return "figure.outdoor.cycle"
        case .beach:
            return "figure.equestrian.sports"
        case .mountaineering:
            return "figure.hiking"
        }
    }
}
    
extension TrailsStyle: AppEnum {
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        TypeDisplayRepresentation(
            name: LocalizedStringResource("Trail", table: "AppIntents"),
            numericFormat: LocalizedStringResource("\(placeholder: .int) trails", table: "AppIntents")
        )
    }
    
    static var caseDisplayRepresentations: [TrailsStyle: DisplayRepresentation] = [
        .biking: DisplayRepresentation(title: "骑行",
                                       subtitle: "骑行 子标题",
                                       image: imageRepresentation[.biking]),
        
        .beach: DisplayRepresentation(title: "海滩",
                                           subtitle: "海滩 sports",
                                           image: imageRepresentation[.beach]),
        
        .mountaineering: DisplayRepresentation(title: "爬山",
                                       subtitle: "爬山 outdoor walk",
                                       image: imageRepresentation[.mountaineering])
    ]
    
    private static var imageRepresentation: [TrailsStyle: DisplayRepresentation.Image] = [
        .biking: DisplayRepresentation.Image(systemName: TrailsStyle.biking.symbol),
        .beach: DisplayRepresentation.Image(systemName: TrailsStyle.beach.symbol),
        .mountaineering: DisplayRepresentation.Image(systemName: TrailsStyle.mountaineering.symbol)
    ]
}
