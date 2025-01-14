//
//  MyAppIntentsApp.swift
//  MyAppIntents
//
//  Created by 童星 on 2024/10/24.
//

import SwiftUI

@main
struct MyAppIntentsApp: App {
    init() {
        AppShortcuts.updateAppShortcutParameters()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
