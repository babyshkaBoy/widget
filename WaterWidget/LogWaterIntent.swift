//
//  LogWaterIntent.swift
//  widgets
//
//  Created by Азамат Баев on 24.06.2024.
//


import Foundation
import AppIntents

extension  Notification.Name {
    static let widgetChangedData = Notification.Name("WidgetChangedData")
}

struct LogWaterIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Water Logger"
    static var ddescription = IntentDescription("Hydrate now")
    
    func perform() async throws -> some IntentResult {
        let updated = await LogManager.shared.increaseWaterAsync(waterAmount: 250)
        if updated {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .widgetChangedData, object: nil)
            }
        }

        return .result()
    }
    
    
}
