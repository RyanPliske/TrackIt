import Foundation
import Parse

class TRRecordService {
    
    func createRecordWithItem(item: String, quantity: Int, itemType: TRRecordType, date: NSDate, completion: TRCreateRecordCompletion?) -> TRRecord {
        let record = TRRecord(className: "record")
        record.itemName = item
        record.itemQuantity = quantity
        record.itemType = itemType.description
        record.itemDate = TRDateFormatter.descriptionForDate(date)
        saveRecordToPhoneWithRecord(record, completion: completion)
        return record
    }
    
    private func saveRecordToPhoneWithRecord(record: TRRecord, completion: TRCreateRecordCompletion?) {
        let BackgroundSaveCompletion: PFBooleanResultBlock = {
            (success, error) in
            if let completionBlock = completion where (error == nil) {
                print("Record saved.")
                completionBlock()
            }
        }
        record.pinInBackgroundWithBlock(BackgroundSaveCompletion)
    }
    
    private func saveRecordToParseDatabase(record: TRRecord) {
        record.saveEventually(nil)
    }
    
    func readAllRecordsFromPhoneWithSortType(sortType: TRRecordType, completion: PFArrayResultBlock) {
        let BackgroundRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
                completion(objects, error)
        }
        let query = PFQuery(className: "record")
        query.fromLocalDatastore()
        query.whereKey("type", equalTo: sortType.description)
        query.findObjectsInBackgroundWithBlock(BackgroundRetrievalCompletion)
    }
    
    func readAllRecordsFromPhoneWithSearchText(searchText: String, sortType: TRRecordType, completion: PFArrayResultBlock?) {
        let BackgroundRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let completionBlock = completion {
                completionBlock(objects, error)
            }
        }
        
        let withinDate = PFQuery(className: "record")
        withinDate.fromLocalDatastore()
        withinDate.whereKey("date", containsString: searchText)
        
        let withinItem = PFQuery(className: "record")
        withinItem.fromLocalDatastore()
        withinItem.whereKey("item", containsString: searchText)
        
        let query = PFQuery.orQueryWithSubqueries([withinDate, withinItem])
        query.fromLocalDatastore()
        query.whereKey("type", equalTo: sortType.description)
        query.findObjectsInBackgroundWithBlock(BackgroundRetrievalCompletion)
    }
    
    func deleteAllRecordsFromPhone() {
        TRRecord.unpinAllObjects()
    }
    
    func deleteRecord(record: TRRecord) {
        record.unpin()
    }
}