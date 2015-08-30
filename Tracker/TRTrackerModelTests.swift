import XCTest

class TRTrackerModelTests: XCTestCase {
    let mockRecordService = MockRecordService()
    var testObject: TRTrackerModel!
    
    override func setUp() {
        super.setUp()
        testObject = TRTrackerModel(recordService: self.mockRecordService)
    }
    
    func testWhenTrackItemAtRowIsCalled_ThenCreateRecordWithItemIsCalledOnTheRecordService() {
        XCTAssertFalse(mockRecordService.createRecordCalled)
        testObject.trackItemAtRow(0, quantityRow: 1, type: .TrackAction, date: NSDate())
        XCTAssertTrue(mockRecordService.createRecordCalled)
    }
}
