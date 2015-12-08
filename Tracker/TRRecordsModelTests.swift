import XCTest

class TRRecordsModelTests: XCTestCase {
    let mockRecordService = MockRecordService()
    let mockItemService = MockItemService()
    var itemsModel: TRItemsModel?
    var testObject: TRRecordsModel!
    
    override func setUp() {
        super.setUp()
        itemsModel = TRItemsModel(itemService: self.mockItemService)
        testObject = TRRecordsModel(recordService: self.mockRecordService, itemsModel: itemsModel!)
    }
    
    func testWhencreateRecordUsingRowIsCalled_ThenCreateRecordWithItemIsCalledOnTheRecordService() {
        XCTAssertFalse(mockRecordService.createRecordCalled)
        testObject.createRecordUsingRow(0, quantity: 1.0, type: .TrackAction, date: NSDate()) { () -> Void in
        }
        XCTAssertTrue(mockRecordService.createRecordCalled)
    }
    
    func testWhenCreatingRecord_TheCorrectParametersAreUsed() {
        let row = 0
        let expectedItemName = itemsModel?.allItems[row].name
        let expectedItemQuantity : Float = 4.0
        let itemType = TRRecordType.TrackAction
        let expectedItemType = itemType.description
        let itemDate = NSDate()
        let expectedItemDate = TRDateFormatter.descriptionForDate(itemDate)
        
        testObject.createRecordUsingRow(row, quantity: expectedItemQuantity, type: itemType, date: itemDate) { () -> Void in
        }
        
        XCTAssertEqual(expectedItemName, mockRecordService.createdRecord?.itemName)
        XCTAssertEqual(expectedItemQuantity, mockRecordService.createdRecord?.itemQuantity)
        XCTAssertEqual(expectedItemType, mockRecordService.createdRecord?.itemType)
        XCTAssertEqual(expectedItemDate, mockRecordService.createdRecord?.dateDescription)
    }
}
