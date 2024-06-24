//
//  WaterWidgetEntryView.swift
//  widgets
//
//  Created by Азамат Баев on 24.06.2024.
//

import SwiftUI

struct WaterWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    var maxValue = 3000
    var entryPercent: Int {
        Int(CGFloat(entry.amount) / CGFloat(maxValue) * CGFloat(100))
    }
    var hoursFromNow: Int {
        let ononeDayAhead = Calendar.current.date(byAdding: .day, value: 1, to: .now)!
        let startOfNextDay = Calendar.current.startOfDay(for: ononeDayAhead)
        let diffConponents = Calendar.current.dateComponents([.hour], from: entry.date, to: startOfNextDay)
        return diffConponents.hour ?? 0
    }

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            VStack {
                Text("Кол-во воды")
                HStack {
                    BottleView(waterAmount: .constant(entry.amount), maxVolume: .constant(maxValue), bottleType: .small)
                    VStack {
                        Text("\(entryPercent)%")
                        Text("Время: \(hoursFromNow)").font(.system(size: 12))
                    }
                }
            }.foregroundStyle(Color("AppColor"))
         default:
            VStack {
                Text("Ваш уровень воды за сегодня")
                HStack(alignment: .center, spacing: 15) {
                    Spacer()
                    BottleView(waterAmount: .constant(entry.amount), maxVolume: .constant(maxValue), bottleType: .small)
                    VStack {
                        Text("\(entryPercent)%").font(.title2)
                        Text("Осталось времени: \(hoursFromNow)")
                    }
                    if #available(iOS 17.0, *) {
                        Button(intent: LogWaterIntent()) {
                            Image(systemName: entry.amount == maxValue ? "checkmark.circle.fill" : "plus.circle.fill").resizable().frame(width: 30, height: 30)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    Spacer()
                }
            }.foregroundStyle(Color("AppColor"))
        }
        
    }
}
