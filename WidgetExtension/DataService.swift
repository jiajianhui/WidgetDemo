//
//  DataService.swift
//  WidgetExtensionExtension
//
//  Created by 贾建辉 on 2024/2/29.
//

import Foundation
import SwiftUI

struct DataService {
    @AppStorage("num", store: UserDefaults(suiteName: "group.com.jjh.WidgetDemo")) var num = 0
    
    func add() {
        if num < 10 {
            num += 1
        }
    }
    func sub() {
        if num >= 0 {
            num -= 1
        }
    }
    
    func finalResult() -> Int {
        return num
    }
}
