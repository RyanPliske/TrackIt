import Foundation
import Parse

public class TRRecordService : NSObject {
    
    public func createRecordWithItem(item: String, quantity: Int, itemType: TRTrackingType, date: NSDate) -> TRRecord {
        let record = TRRecord(className: "record")
        record.itemName = item
        record.itemQuantity = quantity
        record.itemType = TRRecord.itemTypeFrom(itemType)
        record.itemDate = TRDateFormatter.descriptionForDate(date)
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
    
    public func readRecordsFromPhone(completion: PFArrayResultBlock) {
        let BackgroundRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
                completion(objects, error)
        }
        let query = PFQuery(className: "record")
        query.fromLocalDatastore()
        let date = TRDateFormatter.descriptionForDate(NSDate())
        query.whereKey("date", equalTo: date)
        query.findObjectsInBackgroundWithBlock(BackgroundRetrievalCompletion)
    }
    
//    public func deleteAllRecordsFromPhone() {
//        
//    }
}