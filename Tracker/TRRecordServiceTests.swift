import XCTest
import Parse

class TRRecordServiceTests : XCTestCase {
    let testObject = TRRecordService()
    
    func testWhenCreatingRecord_WithActionType_ThenCorrectRecordIsCreated() {
        let expectedQuantity = 4
        let expectedItem = "Baby Kicks"
        let expectedType = "action"
        let expectedRecord = PFObject(className: "record")
        expectedRecord["item"] = expectedItem
        expectedRecord["quantity"] = expectedQuantity
        expectedRecord["type"] = expectedType
        
        let returnedRecord = testObject.createRecordWithItem(expectedItem, quantity: expectedQuantity, itemType: TRTrackingType.TrackAction, date: NSDate())
        
        XCTAssert(expectedRecord.objectForKey("item")!.isEqualToString(returnedRecord.objectForKey("item") as! String))
        XCTAssert(expectedRecord.objectForKey("quantity")!.isEqualToNumber(returnedRecord.objectForKey("quantity") as! Int))
        XCTAssert(expectedRecord.objectForKey("type")!.isEqualToString(returnedRecord.objectForKey("type") as! String))
    }
    
    func testWhenCreatingRecord_WithUrgeType_ThenCorrectRecordIsCreated() {
        let expectedQuantity = 5
        let expectedItem = "Drinks"
        let expectedRecord = PFObject(className: "record")
        expectedRecord["item"] = expectedItem
        expectedRecord["quantity"] = expectedQuantity
        expectedRecord["type"] = "urge"
        
        let returnedRecord = testObject.createRecordWithItem(expectedItem, quantity: expectedQuantity, itemType: TRTrackingType.TrackUrge, date: NSDate())
        XCTAssert(expectedRecord.objectForKey("item")!.isEqualToString(returnedRecord.objectForKey("item") as! String))
        XCTAssert(expectedRecord.objectForKey("quantity")!.isEqualToNumber(returnedRecord.objectForKey("quantity") as! Int))
        XCTAssert(expectedRecord.objectForKey("type")!.isEqualToString(returnedRecord.objectForKey("type") as! String))
    }
    
    
}