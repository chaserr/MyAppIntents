//
//  OpenTrailIntent.swift
//  MyAppIntents
//
//  Created by 童星 on 2024/10/24.
//

import Foundation
import AppIntents

// 定义一个 AppIntent，用于选择并打开路径
struct OpenTrailIntent: AppIntent {
    static var title: LocalizedStringResource = "打开路径意图标题"

    static var description = IntentDescription(
        "这是一个APPintent的demo的意图描述",
        categoryName: "路径分类",
        searchKeywords: ["Trail, Map"],
        resultValueName: "Selected Trails"
    )
    
    static var openAppWhenRun: Bool = false

    // 如果parameterSummary 未打开，那么系统会检测所有title类型的参数，并在编辑快捷方式时列出，否则，优先展示parameterSummary
    static var parameterSummary: some ParameterSummary {
        Summary("Summary 打开\(\.$trailEntity) 类型：\(\.$trailStyle)") // 如果提供了summary，优先展示带参数的summary，否者走suggestedEntitiezs
    }
    
    // 有几个title，在编辑快捷方式时就会展示几个选项，可以同时存在，requestValueDialog当用户没有选中，直接运行快捷方式时，会出现弹框，标题就是requestValueDialog
    // 编辑意图时显示名称，供快捷方式界面展示
    @Parameter(title: "路径参数", requestValueDialog: "你想要打开什么路径？")
    var trailEntity: TrailEntity

    
    @Parameter(title: "带参数路径", requestValueDialog: "带参数你想要打开什么路径？")
    var trailStyle: TrailsStyle
    

    // perform 方法执行打开路径的操作
    func perform() async throws -> some IntentResult & ProvidesDialog {
        return .result(dialog: "打开 \(trailEntity.name)对话框内容")
    }
}
