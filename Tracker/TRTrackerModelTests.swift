import XCTest

class TRTrackerModelTests: XCTestCase {
    let testObject = TRTrackerModel()
    
    override func setUp() {
        super.setUp()
    }
    
    func testWhenTrackItemAtRowIsCalled_ThenCorrectRecordIsCreated() {
        let expectedRecord = PFObject(className: "record")
        expectedRecord["item"] = "Drinks"
        expectedRecord["quantity"] = 4
        expectedRecord["type"] = "action"
        
        self.testObject.trackItemAtRow(0, quantityRow: 3, type: TRTrackingType.TrackAction)
        
        XCTAssert(expectedRecord.objectForKey("item")!.isEqualToString(self.testObject.recordToTrack!.objectForKey("item") as! String))
        
        XCTAssert(expectedRecord.objectForKey("quantity")!.isEqualToNumber(self.testObject.recordToTrack!.objectForKey("quantity") as! Int))
        
        XCTAssert(expectedRecord.objectForKey("type")!.isEqualToString(self.testObject.recordToTrack!.objectForKey("type") as! String))
        
        XCTAssertNotNil(self.testObject.recordToTrack)
    }
}
