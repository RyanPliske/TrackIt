import XCTest
import Parse

class MockRecordService: TRRecordService {
    override func createRecordWithItem(item: String, quantity: Int, itemType: TRTrackingType, date: NSDate) -> PFObject {
        let expectedQuantity = 4
        let expectedRecord = PFObject(className: "record")
        expectedRecord["item"] = "Baby Kicks"
        expectedRecord["quantity"] = expectedQuantity
        expectedRecord["type"] = "action"
        expectedRecord["date"] = date
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
    
    func testWhenTrackItemAtRowIsCalled_ARecordIsCreatedInRecordsArray() {
        self.testObject.trackItemAtRow(5, quantityRow: 4, type: TRTrackingType.TrackAction, date: NSDate())
        XCTAssertFalse(testObject.records.isEmpty)
        XCTAssertEqual(testObject.records.count, 1)
    }
}
