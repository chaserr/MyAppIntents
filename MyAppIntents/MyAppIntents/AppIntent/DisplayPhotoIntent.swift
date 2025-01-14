//
//  DisplayPhotoIntent.swift
//  MyAppIntents
//
//  Created by 童星 on 2024/10/28.
//

import Foundation
import AppIntents
import SwiftUI

struct DisplayPhotoIntent: AppIntent {
    static var title: LocalizedStringResource = "Display Photo"
    
    // 文件参数，用于接收照片文件
    @Parameter(title: "Photo", supportedContentTypes: [.jpeg, .rtf, .image])
    var photoFile: IntentFile
    
    static var parameterSummary: some ParameterSummary {
        Summary("预览\(\.$photoFile)")
    }
    
    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        // 执行文件传递和处理逻辑
        return .result(dialog: "Here's your photo!", view: DisplayPhotoView(photoFile: photoFile))
    }
}

// 显示 IntentFile 图片
struct DisplayPhotoView: View {
    let photoFile: IntentFile
    
    var body: some View {
        if let uiImage = UIImage(data: photoFile.data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
        } else {
            Text("Unable to display image.")
        }
    }
}
