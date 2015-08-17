import Foundation

class RecordServices : NSObject {
    // MARK: CRUD Records
    func createRecordWithItem(item: String, quantity: Int, itemType: TRTrackingType) -> PFObject {
        let record = PFObject(className: "record")
        record["item"] = item
        record["quantity"] = quantity
        let type = (itemType == TRTrackingType.TrackAction) ? "action" : "urge"
        record["type"] = type
        return record
    }
    
    func saveRecordToPhoneWithRecord(record: PFObject) {
        record.saveInBackgroundWithBlock {
            (success: ObjCBool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
    }
}