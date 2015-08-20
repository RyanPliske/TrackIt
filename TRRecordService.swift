import Foundation

class TRRecordService : NSObject {
    
    // MARK: CRUD Records
    
    func createRecordWithItem(item: String, quantity: Int, itemType: TRTrackingType, date: NSDate) -> PFObject {
        let record = PFObject(className: "record")
        record["item"] = item
        record["quantity"] = quantity
        let type = (itemType == TRTrackingType.TrackAction) ? "action" : "urge"
        record["type"] = type
        record["date"] = date
        
        self.saveRecordToPhoneWithRecord(record)
        
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