//
//  ContentView.swift
//  MyAppIntents
//
//  Created by 童星 on 2024/10/24.
//

import SwiftUI
import AppIntents

struct ContentView: View {
    @State private var selectedTrail: TrailEntity?
    @State private var visiable: Bool = true

    var body: some View {
        NavigationView {
            List(TrailDataManager.shared.trails, id: \.id) { trail in
                Button(action: {
                    selectedTrail = trail
                }) {
                    Text(trail.name)
                }
            }
            .navigationTitle("Trails")
            .sheet(item: $selectedTrail) { trail in
                TrailDetailView(trail: trail)
            }
        }
        HStack {
            Spacer(minLength: 10)
            SiriTipView(intent: OpenTrailIntent(), isVisible: $visiable)
                .siriTipViewStyle(.automatic)
            Spacer(minLength: 10)
        }
        ShortcutsLink()
            .shortcutsLinkStyle(.automaticOutline)
    }
}
#Preview {
    ContentView()
}
