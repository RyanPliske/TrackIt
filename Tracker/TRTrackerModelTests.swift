import XCTest

class TRTrackerModelTests: XCTestCase {
    let testObject = TRTrackerModel()
    
    override func setUp() {
        super.setUp()
    }
    
    func testWhenTrackItemAtRowIsCalled_WithTrackingTypeAction_ThenCorrectRecordIsCreated() {
        let expectedQuantity = 4
        let expectedRecord = PFObject(className: "record")
        expectedRecord["item"] = "Baby Kicks"
        expectedRecord["quantity"] = expectedQuantity
        expectedRecord["type"] = "action"
        
        self.testObject.trackItemAtRow(5, quantityRow: expectedQuantity - 1, type: TRTrackingType.TrackAction)
        
        XCTAssert(expectedRecord.objectForKey("item")!.isEqualToString(self.testObject.recordToTrack!.objectForKey("item") as! String))
        XCTAssert(expectedRecord.objectForKey("quantity")!.isEqualToNumber(self.testObject.recordToTrack!.objectForKey("quantity") as! Int))
        XCTAssert(expectedRecord.objectForKey("type")!.isEqualToString(self.testObject.recordToTrack!.objectForKey("type") as! String))
        XCTAssertNotNil(self.testObject.recordToTrack)
    }
    
    func testWhenTrackItemAtRowIsCalled_WithTrackingTypeUrge_ThenCorrectRecordIsCreated() {
        let expectedQuantity = 5
        let expectedRecord = PFObject(className: "record")
        expectedRecord["item"] = "Drinks"
        expectedRecord["quantity"] = expectedQuantity
        expectedRecord["type"] = "urge"
        
        self.testObject.trackItemAtRow(0, quantityRow: expectedQuantity - 1, type: TRTrackingType.TrackUrge)
        
        XCTAssert(expectedRecord.objectForKey("item")!.isEqualToString(self.testObject.recordToTrack!.objectForKey("item") as! String))
        XCTAssert(expectedRecord.objectForKey("quantity")!.isEqualToNumber(self.testObject.recordToTrack!.objectForKey("quantity") as! Int))
        XCTAssert(expectedRecord.objectForKey("type")!.isEqualToString(self.testObject.recordToTrack!.objectForKey("type") as! String))
        XCTAssertNotNil(self.testObject.recordToTrack)
    }
}
