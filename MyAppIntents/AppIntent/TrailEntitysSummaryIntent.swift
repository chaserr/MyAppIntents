//
//  TrailEntitysSummary.swift
//  MyAppIntents
//
//  Created by 童星 on 2024/10/25.
//

import Foundation
import AppIntents

struct TrailEntitysSummaryIntent: AppIntent {
    static var title: LocalizedStringResource = "路径内容总结"
    static var description = IntentDescription("路径内容总结快捷方式描述",
                                               categoryName: "路径内容总结分类",
                                               searchKeywords: ["路径汇总"],
                                               resultValueName: "TrailEntity Summary")
    
    func perform() async throws -> some IntentResult & ProvidesDialog & ReturnsValue<TrailEntitysSummary> {
        // 只有这里返回了ReturnsValue类型，才能在对话框中选择参数来进行转化，其中通过Property来标记的参数，都可以作为单独项来进行导出
        let stats = ActivityTracker.shared.trailEntitysSummary
        let dialog = IntentDialog("你使用Transferable完成了Trail的内容转换demo. Incredible!")
        return .result(value: stats, dialog: dialog)
    }
}
