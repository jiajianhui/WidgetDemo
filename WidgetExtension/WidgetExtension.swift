//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by 贾建辉 on 2024/2/29.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    let data = DataService()
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), num: data.progress())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), num: data.progress())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, num: data.progress())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

//小组件的模型
struct SimpleEntry: TimelineEntry {
    let date: Date
    let num: Int
}


//小组件的视图
struct WidgetExtensionEntryView : View {
    
    let data = DataService()
    
    var entry: Provider.Entry
    let lineWidth: CGFloat = 16
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.white.opacity(0.1), lineWidth: lineWidth)
            Circle()
                // CGFloat(num / 10) 与 CGFloat(num) / 10不一样，前者小数部分可能会丢失，后者不会
                .trim(from: 0.0, to: CGFloat(data.progress()) / 10)
                .stroke(.blue, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
            VStack {
                Text(String(data.progress()))
                    .font(.system(size: 24, weight: .heavy, design: .serif))
                    .contentTransition(.numericText()) //小组件的动画效果
                    
                Text("进度")
                    .font(.system(size: 10, weight: .bold))
            }
            .foregroundStyle(.white)
        }
        .padding(10)
        .containerBackground(.blue, for: .widget)
    }
}

struct WidgetExtension: Widget {
    
    //小组件的标识
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WidgetExtensionEntryView(entry: entry)
                    .containerBackground(.black, for: .widget) //设置小组件背景
            } else {
                WidgetExtensionEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    WidgetExtension()
} timeline: {
    //用于预览的
    SimpleEntry(date: .now, num: 1)
    SimpleEntry(date: .now, num: 3)
}
