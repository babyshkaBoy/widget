import Foundation
import CoreData


class LogManager {
    static var shared = LogManager()
    
    func getLatestLog() -> Log? {
        let viewContext = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Log> = Log.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = 1
        
        do {
            let latestLogs = try viewContext.fetch(fetchRequest)
            guard latestLogs.first != nil && Calendar.current.isDateInToday(latestLogs.first!.timestamp!) else { return nil }
            return latestLogs.first
        } catch {
            print(error)
        }
        
        return nil
    }

    
    func saveLog(waterAmount: Int) -> Void {
        let viewContext = PersistenceController.shared.container.viewContext
        let log = Log(context: viewContext)
        log.amount = Int16(waterAmount)
        log.timestamp = Date.now
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }

    func increaseWaterAsync(waterAmount: Int) async -> Bool {
        let log = getLatestLog()
        if log == nil {
            saveLog(waterAmount: waterAmount)
        }
        if log != nil && Int(log?.amount ?? 0) < 3000 {
            saveLog(waterAmount: Int(log?.amount ?? 0) + waterAmount)
        } else {
            return false
        }
        return true
    }
}
