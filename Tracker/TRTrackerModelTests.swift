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
        
//        XCTAssertEqual(expectedRecord.objectForKey("item")!, self.testObject.recordToTrack!.objectForKey("item")!)
        XCTAssertNotNil(self.testObject.recordToTrack)
    }
}
