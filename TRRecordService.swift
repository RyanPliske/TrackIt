import Foundation
import Parse

public class TRRecordService : NSObject {
    
    public func createRecordWithItem(item: String, quantity: Int, itemType: TRTrackingType, date: NSDate, completion: TRCreateRecordCompletion?) -> TRRecord {
        let record = TRRecord(className: "record")
        record.itemName = item
        record.itemQuantity = quantity
        record.itemType = TRRecord.stringFromSortType(itemType)
        record.itemDate = TRDateFormatter.descriptionForDate(date)
        saveRecordToPhoneWithRecord(record, completion: completion)
        return record
    }
    
    private func saveRecordToPhoneWithRecord(record: TRRecord, completion: TRCreateRecordCompletion?) {
        let BackgroundSaveCompletion: PFBooleanResultBlock = {
            (success, error) in
            if (error == nil && completion != nil) {
                print("Record saved.")
                completion!()
            }
        }
        record.pinInBackgroundWithBlock(BackgroundSaveCompletion)
    }
    
    private func saveRecordToParseDatabase(record: TRRecord) {
        record.saveEventually(nil)
    }
    
    public func readTodaysRecordsFromPhoneWithSortType(sortType: String, completion: PFArrayResultBlock) {
        let BackgroundRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
                completion(objects, error)
        }
        let query = PFQuery(className: "record")
        query.fromLocalDatastore()
        let date = TRDateFormatter.descriptionForDate(NSDate())
        query.whereKey("date", equalTo: date)
        query.whereKey("type", equalTo: sortType)
        query.findObjectsInBackgroundWithBlock(BackgroundRetrievalCompletion)
    }
    
    public func deleteAllRecordsFromPhone() {
        TRRecord.unpinAllObjects()
    }
}