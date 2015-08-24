import XCTest
import Parse
import Tracker

class TRRecordServiceTests : XCTestCase {
    let testObject = TRRecordService()
    
    func testWhenCreatingRecord_WithActionType_ThenCorrectRecordIsCreated() {
        let expectedQuantity = 4
        let expectedItem = "Baby Kicks"
        let expectedType = "action"
        let expectedDate = TRDateFormatter.descriptionForDate(NSDate())
        
        let expectedRecord = TRRecord(className: "record")
        expectedRecord.itemName = expectedItem
        expectedRecord.itemQuantity = expectedQuantity
        expectedRecord.itemType = expectedType
        expectedRecord.itemDate = expectedDate
        
        let returnedRecord = testObject.createRecordWithItem(expectedItem, quantity: expectedQuantity, itemType: TRTrackingType.TrackAction, date: NSDate())
        
        XCTAssertEqual(expectedRecord.itemName!, returnedRecord.itemName!)
        XCTAssertEqual(expectedRecord.itemQuantity!, returnedRecord.itemQuantity!)
        XCTAssertEqual(expectedRecord.itemType!, returnedRecord.itemType!)
        XCTAssertEqual(expectedRecord.itemDate, returnedRecord.itemDate!)
    }
    
    func testWhenCreatingRecord_WithUrgeType_ThenCorrectRecordIsCreated() {
        let expectedQuantity = 5
        let expectedItem = "Drinks"
        let expectedType = "urge"
        let expectedDate = TRDateFormatter.descriptionForDate(NSDate())
        
        let expectedRecord = TRRecord(className: "record")
        expectedRecord.itemName = expectedItem
        expectedRecord.itemQuantity = expectedQuantity
        expectedRecord.itemType = expectedType
        expectedRecord.itemDate = expectedDate
        
        let returnedRecord = testObject.createRecordWithItem(expectedItem, quantity: expectedQuantity, itemType: TRTrackingType.TrackUrge, date: NSDate())
        
        XCTAssertEqual(expectedRecord.itemName!, returnedRecord.itemName!)
        XCTAssertEqual(expectedRecord.itemQuantity!, returnedRecord.itemQuantity!)
        XCTAssertEqual(expectedRecord.itemType!, returnedRecord.itemType!)
        XCTAssertEqual(expectedRecord.itemDate, returnedRecord.itemDate!)
    }
    
    
}