import XCTest
import Parse
import Tracker

class MockRecordService: TRRecordService {
    override func createRecordWithItem(item: String, quantity: Int, itemType: TRTrackingType, date: NSDate, completion: TRCreateRecordCompletion?) -> TRRecord {
        let expectedQuantity = 4
        let expectedRecord = TRRecord(className: "record")
        expectedRecord.itemName = "Baby Kicks"
        expectedRecord.itemQuantity = expectedQuantity
        expectedRecord.itemType = "action"
        expectedRecord.itemDate = TRDateFormatter.descriptionForDate(date)
        return expectedRecord
    }
    
    override func readTodaysRecordsFromPhoneWithSortType(sortType: TRTrackingType, completion: PFArrayResultBlock) {
        let record = TRRecord(className: "record")
        var records = [TRRecord]()
        records.append(record)
        completion(records as [AnyObject]?, nil)
    }
}

class TRTrackerModelTests: XCTestCase {
    let mockRecordService = MockRecordService()
    var testObject: TRTrackerModel!
    
    override func setUp() {
        super.setUp()
        testObject = TRTrackerModel(recordService: self.mockRecordService)
    }
}
