import Parse

class MockRecordService: TRRecordService {
    var createRecordCalled = false
    
    override func createRecordWithItem(item: String, quantity: Int, itemType: TRRecordType, date: NSDate, completion: TRCreateRecordCompletion?) -> MockRecord {
        let expectedQuantity = 4
        let expectedRecord = MockRecord(className: "record")
        expectedRecord.itemName = "Baby Kicks"
        expectedRecord.itemQuantity = expectedQuantity
        expectedRecord.itemType = "action"
        expectedRecord.itemDate = TRDateFormatter.descriptionForDate(date)
        createRecordCalled = true
        return expectedRecord
    }
    
    override func readAllRecordsFromPhoneWithSortType(sortType: TRRecordType, completion: PFArrayResultBlock) {
        let record = MockRecord(className: "record")
        var records = [MockRecord]()
        records.append(record)
        completion(records as [AnyObject]?, nil)
    }
}