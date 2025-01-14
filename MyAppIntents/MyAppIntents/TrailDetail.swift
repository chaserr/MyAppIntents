//
//  TrailDetail.swift
//  MyAppIntents
//
//  Created by 童星 on 2024/10/24.
//

import Foundation
import SwiftUI

struct TrailDetailView: View {
    let trail: TrailEntity

    var body: some View {
        VStack {
            Text("\(trail.name) Details")
                .font(.largeTitle)
                .padding()

            Spacer()
        }
    }
}
