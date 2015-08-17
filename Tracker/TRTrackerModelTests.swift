import XCTest

class TRTrackerModelTests: XCTestCase {
    let recordService = TRRecordService()
    var testObject: TRTrackerModel!
    
    override func setUp() {
        super.setUp()
        testObject = TRTrackerModel(recordService: self.recordService)
    }
    
    func testWhenTrackItemAtRowIsCalled_WithTrackingTypeAction_ThenCorrectRecordIsCreated() {
        let expectedQuantity = 4
        let expectedRecord = PFObject(className: "record")
        expectedRecord["item"] = "Baby Kicks"
        expectedRecord["quantity"] = expectedQuantity
        expectedRecord["type"] = "action"
        
        self.testObject.trackItemAtRow(5, quantityRow: expectedQuantity - 1, type: TRTrackingType.TrackAction)
        
        let returnedRecord = self.testObject.records[0]
        XCTAssert(expectedRecord.objectForKey("item")!.isEqualToString(returnedRecord.objectForKey("item") as! String))
        XCTAssert(expectedRecord.objectForKey("quantity")!.isEqualToNumber(returnedRecord.objectForKey("quantity") as! Int))
        XCTAssert(expectedRecord.objectForKey("type")!.isEqualToString(returnedRecord.objectForKey("type") as! String))
        XCTAssertNotNil(self.testObject.records)
    }
    
    func testWhenTrackItemAtRowIsCalled_WithTrackingTypeUrge_ThenCorrectRecordIsCreated() {
        let expectedQuantity = 5
        let expectedRecord = PFObject(className: "record")
        expectedRecord["item"] = "Drinks"
        expectedRecord["quantity"] = expectedQuantity
        expectedRecord["type"] = "urge"
        
        self.testObject.trackItemAtRow(0, quantityRow: expectedQuantity - 1, type: TRTrackingType.TrackUrge)
        
        let returnedRecord = self.testObject.records[0]
        XCTAssert(expectedRecord.objectForKey("item")!.isEqualToString(returnedRecord.objectForKey("item") as! String))
        XCTAssert(expectedRecord.objectForKey("quantity")!.isEqualToNumber(returnedRecord.objectForKey("quantity") as! Int))
        XCTAssert(expectedRecord.objectForKey("type")!.isEqualToString(returnedRecord.objectForKey("type") as! String))
        XCTAssertNotNil(self.testObject.records)
    }
}
