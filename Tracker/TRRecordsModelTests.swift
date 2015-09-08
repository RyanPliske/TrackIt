import XCTest

class TRRecordsModelTests: XCTestCase {
    let mockRecordService = MockRecordService()
    var testObject: TRRecordsModel!
    
    override func setUp() {
        super.setUp()
        testObject = TRRecordsModel(recordService: self.mockRecordService)
    }
    
    func testWhenTrackItemAtRowIsCalled_ThenCreateRecordWithItemIsCalledOnTheRecordService() {
        XCTAssertFalse(mockRecordService.createRecordCalled)
        testObject.trackItemAtRow(0, quantityRow: 1, type: .TrackAction, date: NSDate())
        XCTAssertTrue(mockRecordService.createRecordCalled)
    }
}
