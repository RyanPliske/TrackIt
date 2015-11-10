import Foundation
import Parse

class TRRecordService {
    
    func createRecordWithItem(item: String, quantity: Float, itemType: TRRecordType, date: NSDate, completion: TRCreateRecordCompletion?) -> TRRecord {
        let record = TRRecord(className: "record")
        record.itemName = item
        record.itemQuantity = quantity
        record.itemType = itemType.description
        record.dateDescription = TRDateFormatter.descriptionForDate(date)
        record.date = date
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
    
    func readAllRecordsFromPhoneWithSortType(sortType: TRRecordType, completion: PFQueryArrayResultBlock) {
        let BackgroundRetrievalCompletion: PFQueryArrayResultBlock = {
            (objects: [PFObject]?, error: NSError?) in
                completion(objects, error)
        }
        let query = PFQuery(className: "record")
        query.fromLocalDatastore()
        query.whereKey("type", equalTo: sortType.description)
        query.findObjectsInBackgroundWithBlock(BackgroundRetrievalCompletion)
    }
    
    
    func readAllRecordsFromPhoneWithItemName(itemName: String, dateDescription: String, completion: TRSearchForItemCompletion) {
        let BackgroundRetrievalCompletion: PFQueryArrayResultBlock = {
            (objects: [PFObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                completion(records, error)
            }
        }
        
        let query = PFQuery(className: "record")
        query.fromLocalDatastore()
        query.whereKey("item", equalTo: itemName)
        query.whereKey("date", equalTo: dateDescription)
        query.whereKey("type", equalTo: TRRecordType.TrackAction.description)
        query.findObjectsInBackgroundWithBlock(BackgroundRetrievalCompletion)
    }
    
    func readAllRecordsFromPhoneWithItemName(itemName: String, completion: TRSearchForItemCompletion) {
        let BackgroundRetrievalCompletion: PFQueryArrayResultBlock = {
            (objects: [PFObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                completion(records, error)
            }

        }
        
        let query = PFQuery(className: "record")
        query.fromLocalDatastore()
        query.whereKey("item", equalTo: itemName)
        query.whereKey("type", equalTo: TRRecordType.TrackAction.description)
        query.findObjectsInBackgroundWithBlock(BackgroundRetrievalCompletion)
    }
    
    func readAllRecordsFromPhoneWithItemName(itemName: String) -> [TRRecord] {
        let query = PFQuery(className: "record")
        query.fromLocalDatastore()
        query.whereKey("item", equalTo: itemName)
        query.whereKey("type", equalTo: TRRecordType.TrackAction.description)
        do {
            let records = try query.findObjects() as! [TRRecord]
            return records
        } catch {
            return []
        }
    }
    
    func readAllRecordsFromPhoneWithSearchText(searchText: String, sortType: TRRecordType, completion: PFQueryArrayResultBlock?) {
        let BackgroundRetrievalCompletion: PFQueryArrayResultBlock = {
            (objects: [PFObject]?, error: NSError?) in
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
        do {
            try TRRecord.unpinAllObjects()
        } catch {
            
        }
    }
    
    func deleteRecord(record: TRRecord) {
        do {
            try record.unpin()
        } catch {
            
        }
    }
}