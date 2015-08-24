import XCTest
import Parse
import Tracker

class MockRecordService: TRRecordService {
    override func createRecordWithItem(item: String, quantity: Int, itemType: TRTrackingType, date: NSDate) -> TRRecord {
        let expectedQuantity = 4
        let expectedRecord = TRRecord(className: "record")
        expectedRecord.itemName = "Baby Kicks"
        expectedRecord.itemQuantity = expectedQuantity
        expectedRecord.itemType = "action"
        expectedRecord.itemDate = TRDateFormatter.descriptionForDate(date)
        return expectedRecord
    }
}

class TRTrackerModelTests: XCTestCase {
    let recordService = MockRecordService()
    var testObject: TRTrackerModel!
    
    override func setUp() {
        super.setUp()
        testObject = TRTrackerModel(recordService: self.recordService)
    }
    
    func testRecordsArrayIsEmpty() {
        XCTAssertTrue(testObject.records.isEmpty)
    }
    
    
    
}
