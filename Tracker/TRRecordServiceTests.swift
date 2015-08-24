import XCTest
import Parse
import Tracker

class TRRecordServiceTests : XCTestCase {
    let testObject = TRRecordService()
    
    override func setUp() {
        testObject.deleteAllRecordsFromPhone()
    }
    
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
        
        let returnedRecord = testObject.createRecordWithItem(expectedItem, quantity: expectedQuantity, itemType: TRTrackingType.TrackAction, date: NSDate(), completion: nil)
        
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
        
        let returnedRecord = testObject.createRecordWithItem(expectedItem, quantity: expectedQuantity, itemType: TRTrackingType.TrackUrge, date: NSDate(), completion: nil)
        
        XCTAssertEqual(expectedRecord.itemName!, returnedRecord.itemName!)
        XCTAssertEqual(expectedRecord.itemQuantity!, returnedRecord.itemQuantity!)
        XCTAssertEqual(expectedRecord.itemType!, returnedRecord.itemType!)
        XCTAssertEqual(expectedRecord.itemDate, returnedRecord.itemDate!)
    }
    
    func testWhenDeletingRecordsFromDevice_ThenZeroRecordsReturnedFromReading() {
        let expectation = expectationWithDescription("Grab Records")

        let RecordsRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                print(records)
                XCTAssertEqual(records.count, 0)
            }
            expectation.fulfill()
        }
        
        testObject.deleteAllRecordsFromPhone()
        testObject.readTodaysRecordsFromPhone(RecordsRetrievalCompletion)
        
        waitForExpectationsWithTimeout(15) { (error: NSError?) -> Void in
            if (error != nil) {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    func testWhenCreadingARecord_ThenReadingRecordsFromDeviceReturnsOneRecord() {
        testObject.deleteAllRecordsFromPhone()
        testObject.createRecordWithItem("", quantity: 1, itemType: TRTrackingType.TrackUrge, date: NSDate(), completion: nil)
        let expectation = expectationWithDescription("Grab Records")
        
        let RecordsRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                print(records)
                XCTAssertEqual(records.count, 1)
            }
            expectation.fulfill()
        }
        
        testObject.readTodaysRecordsFromPhone(RecordsRetrievalCompletion)
        
        waitForExpectationsWithTimeout(15) { (error: NSError?) -> Void in
            if (error != nil) {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
}