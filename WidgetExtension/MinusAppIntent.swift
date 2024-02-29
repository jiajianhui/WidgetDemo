//
//  SubAppIntent.swift
//  WidgetExtensionExtension
//
//  Created by 贾建辉 on 2024/2/29.
//

import Foundation
import AppIntents

struct MinusAppIntent: AppIntent {
    
    static var title: LocalizedStringResource = "更新目标"
    
    static var description = IntentDescription("将目标增减1")
    
    func perform() async throws -> some IntentResult & ReturnsValue {
        let data = DataService()
        data.sub()
        return .result()
    }
    
}
