import Parse

class MockRecordService: TRRecordService {
    var createRecordCalled = false
    var createdRecord: MockRecord?
    
    override func createRecordWithItem(item: String, quantity: Float, itemType: TRRecordType, date: NSDate, completion: TRCreateRecordCompletion?) -> MockRecord {
        let record = MockRecord(className: "record")
        record.itemName = item
        record.itemQuantity = quantity
        record.itemType = itemType.description
        record.itemDate = TRDateFormatter.descriptionForDate(date)
        createRecordCalled = true
        createdRecord = record
        return record
    }
    
    override func readAllRecordsFromPhoneWithSortType(sortType: TRRecordType, completion: PFArrayResultBlock) {
        let record = MockRecord(className: "record")
        var records = [MockRecord]()
        records.append(record)
        completion(records as [AnyObject]?, nil)
    }
}