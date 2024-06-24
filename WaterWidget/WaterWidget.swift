//
//  WaterWidget.swift
//  WaterWidget
//
//  Created by Азамат Баев on 24.06.2024.
//

import WidgetKit
import SwiftUI

//определяет тип данных которые будут отображаться в виджете
struct WaterEntry: TimelineEntry {
    let date: Date
    let amount: Int
}

struct WaterWidget: Widget {
    let kind: String = "WaterWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WaterWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WaterWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Water widget")
        .description("My Daily water level")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    WaterWidget()
} timeline: {
    WaterEntry(date: .now, amount: 500)
    WaterEntry(date: .now, amount: 500)
}
