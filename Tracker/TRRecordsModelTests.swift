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
    
    func testWhenCreatingRecord_TheCorrectParametersAreUsed() {
        let row = 0
        let expectedItemName = TRTrackableItems().allItems[row]
        let expectedItemQuantity = 4
        let itemType = TRRecordType.TrackAction
        let expectedItemType = TRRecord.stringFromSortType(itemType)
        let itemDate = NSDate()
        let expectedItemDate = TRDateFormatter.descriptionForDate(itemDate)
        
        testObject.createRecordUsingRow(
            row,
            quantityRow: expectedItemQuantity - 1,
            type: itemType,
            date: itemDate
        )
        
        XCTAssertEqual(expectedItemName, mockRecordService.createdRecord?.itemName)
        XCTAssertEqual(expectedItemQuantity, mockRecordService.createdRecord?.itemQuantity)
        XCTAssertEqual(expectedItemType, mockRecordService.createdRecord?.itemType)
        XCTAssertEqual(expectedItemDate, mockRecordService.createdRecord?.itemDate)
    }
}
