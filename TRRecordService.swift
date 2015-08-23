import Foundation
import Parse

class TRRecordService : NSObject {
    
    // MARK: CRUD Records
    func createRecordWithItem(item: String, quantity: Int, itemType: TRTrackingType, var date: NSDate) -> TRRecord {
        let record = TRRecord(className: "record")
        record.itemName = item
        record.itemQuantity = quantity
        record.itemType = TRRecord.itemTypeFrom(itemType)
        let calendar = NSCalendar.currentCalendar()
        let day = calendar.components(NSCalendarUnit.Day, fromDate: date)
        date = calendar.dateFromComponents(day)!
        record.itemDate = date
        saveRecordToPhoneWithRecord(record)
        return record
    }
    
    private func saveRecordToPhoneWithRecord(record: TRRecord) {
        let BackgroundSaveCompletion: PFBooleanResultBlock = {
            (success, error) in
            if (error == nil) {
                print("Record saved.")
            }
        }
        record.pinInBackgroundWithBlock(BackgroundSaveCompletion)
        record.saveEventually(BackgroundSaveCompletion)
    }
    
    func readRecordsFromPhone(completion: PFArrayResultBlock) {
        let BackgroundRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
                completion(objects, error)
        }
        let query = PFQuery(className: "record")
        query.fromLocalDatastore()
        var date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let day = calendar.components(NSCalendarUnit.Day, fromDate: date)
        date = calendar.dateFromComponents(day)!
        query.whereKey("date", equalTo: date)
        query.findObjectsInBackgroundWithBlock(BackgroundRetrievalCompletion)
    }
}