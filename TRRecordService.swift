import Foundation
import Parse

class TRRecordService : NSObject {
    
    // MARK: CRUD Records
    func createRecordWithItem(item: String, quantity: Int, itemType: TRTrackingType, date: NSDate) -> TRRecord {
        let record = TRRecord(className: "record")
        record.itemName = item
        record.itemQuantity = quantity
        record.itemType = TRRecord.itemTypeFrom(itemType)
        record.itemDate = date
        return record
    }
    
    private func saveRecordToPhoneWithRecord(record: PFObject) {
        let BackgroundSaveCompletion : PFBooleanResultBlock = {
            (success, error) in
            if (error == nil) {
                print("Record saved.")
            }
        }
        record.saveEventually(BackgroundSaveCompletion)
    }
}