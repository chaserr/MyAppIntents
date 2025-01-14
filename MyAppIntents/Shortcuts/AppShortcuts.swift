//
//  AppShortcuts.swift
//  MyAppIntents
//
//  Created by 童星 on 2024/10/24.
//

import Foundation
import AppIntents

struct AppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: OpenTrailIntent(),
            // 根据trail来解析所有和trail的意图展示在快捷指令中
            phrases: ["open \(\.$trailEntity) in \(.applicationName) "],
            shortTitle: "打开路径",
            systemImageName: "map"
        )
    }
}
