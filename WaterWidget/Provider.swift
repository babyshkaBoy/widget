//
//  Provider.swift
//  widgets
//
//  Created by Азамат Баев on 24.06.2024.
//

import Foundation
import WidgetKit

struct Provider: TimelineProvider {
    typealias Entry = WaterEntry
    //
    func placeholder(in context: Context) -> WaterEntry {
        WaterEntry(date: Date(), amount: 500)
    }

    func getSnapshot(in context: Context, completion: @escaping (WaterEntry) -> ()) {
        let entry = WaterEntry(date: Date(), amount: 0)
        if !context.isPreview, let log = LogManager.shared.getLatestLog() {
            let entry = WaterEntry(date: log.timestamp!, amount: Int(log.amount))
            completion(entry)
            return
        }
        
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WaterEntry] = []

        let log = LogManager.shared.getLatestLog()
        let entry = WaterEntry(date: log?.timestamp ?? .now, amount: Int(log?.amount ?? 0))
        entries.append(entry)
        
        if log != nil && log?.amount ?? 0 >= 3000 {
            let oneDayAhead = Calendar.current.date(byAdding: .day, value: 1, to: .now)!
            let entry = WaterEntry(date: Calendar.current.startOfDay(for: oneDayAhead), amount: 0)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
