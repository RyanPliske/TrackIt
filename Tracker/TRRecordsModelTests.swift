import XCTest

class TRRecordsModelTests: XCTestCase {
    let mockRecordService = MockRecordService()
    var testObject: TRRecordsModel!
    
    override func setUp() {
        super.setUp()
        testObject = TRRecordsModel(recordService: self.mockRecordService)
    }
    
    func testWhencreateRecordUsingRowIsCalled_ThenCreateRecordWithItemIsCalledOnTheRecordService() {
        XCTAssertFalse(mockRecordService.createRecordCalled)
        testObject.createRecordUsingRow(0, quantityRow: 1, type: .TrackAction, date: NSDate())
        XCTAssertTrue(mockRecordService.createRecordCalled)
    }
}
