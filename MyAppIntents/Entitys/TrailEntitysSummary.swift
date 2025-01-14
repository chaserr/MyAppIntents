//
//  TrailEntitysSummary.swift
//  MyAppIntents
//
//  Created by 童星 on 2024/10/25.
//

import AppIntents
import CoreLocation
import Foundation
import CoreTransferable
import UIKit
import SwiftUI

struct TrailEntitysSummary: TransientAppEntity {
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "typeDisplay路径内容总结")
    
    @Property(title: "总结开始时间")
    var summaryStartDate: Date
    
    @Property(title: "路径名称")
    var name: String
    
    @Property(title: "路径类型")
    var style: TrailsStyle

    @Property(title: "路径ID")
    var id: String
    
    init() {
        summaryStartDate = Date()
        name = ""
        id = ""
        style = .beach
    }
    
    var displayRepresentation: DisplayRepresentation {
        var image = "party.popper"
        var subtitle = LocalizedStringResource("")
        
        return DisplayRepresentation(title: "Display路径内容总结",
                                     subtitle: subtitle,
                                     image: DisplayRepresentation.Image(systemName: image),
                                     synonyms: ["Display 路径总结"])
    }
}

extension TrailEntitysSummary: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .rtf) { summary in
            try summary.asRTFData
        }

        FileRepresentation(exportedContentType: .png) { summary in
            await SentTransferredFile(try summary.asImageFile)
        }
    }
}

extension TrailEntitysSummary {
    
    // 将实体内容导出为 RTF 数据
    var asRTFData: Data {
        let rtfText = """
        我是TrailEntity转成富文本的Demo
        Trail Summary:
        - ID: \(id)
        - Name: \(name)
        - Trail Style: \(style.rawValue)
        """
        
        let attributedString = NSAttributedString(string: rtfText, attributes: [
            .font: UIFont.systemFont(ofSize: 14)
        ])
        
        return try! attributedString.data(from: NSRange(location: 0, length: attributedString.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf])
    }
    
    // 将实体内容导出为图像文件
    @MainActor
    var asImageFile: URL {
        let controller = UIHostingController(rootView: TrailSummaryView(trail: self))
        controller.view.bounds = CGRect(x: 0, y: 0, width: 300, height: 400)
        
        let renderer = UIGraphicsImageRenderer(bounds: controller.view.bounds)
        let image = renderer.image { _ in
            controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        
        // 将图像保存为 PNG 格式
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("TrailSummary.png")
        try? image.pngData()?.write(to: fileURL)
        
        return fileURL
    }
}

// SwiftUI 视图，用于生成图像内容
struct TrailSummaryView: View {
    let trail: TrailEntitysSummary
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("我是TrailEntity转成图片的Demo")
                .font(.title2)
            Text("Trail Summary")
                .font(.title2)
                .bold()
            Text("ID: \(trail.id)")
            Text("Name: \(trail.name)")
            Text("Trail Style: \(trail.style.rawValue)")
            Spacer(minLength: 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
