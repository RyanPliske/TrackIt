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
    
    func testWhenDeletingTracksFromDevice_ThenZeroTracksReturnedFromReading() {
        let expectation = expectationWithDescription("Grab Records")
        let track = TRTrackingType.TrackAction
        
        let RecordsRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                print(records)
                XCTAssertEqual(records.count, 0)
            }
            expectation.fulfill()
        }
        
        testObject.deleteAllRecordsFromPhone()
        testObject.readTodaysRecordsFromPhoneWithSortType(track, completion: RecordsRetrievalCompletion)
        
        waitForExpectationsWithTimeout(15) { (error: NSError?) -> Void in
            if (error != nil) {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    func testWhenCreatingAnUrge_ThenReadingUrgesFromDeviceReturnsOneUrge() {
        testObject.deleteAllRecordsFromPhone()
        let expectation = expectationWithDescription("Grab Records")
        let expectedType = TRTrackingType.TrackUrge
        let RecordsRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                print("✅ \(records)")
                XCTAssertEqual(records.count, 1)
                let expectedSortType = TRRecord.stringFromSortType(expectedType)
                XCTAssertEqual(records[0].itemType, expectedSortType)
                XCTAssertNotEqual(records[0].itemType, "anything")
            }
            expectation.fulfill()
        }
        
        testObject.createRecordWithItem("AnyItem", quantity: 1, itemType: expectedType, date: NSDate(), completion: {
            self.testObject.readTodaysRecordsFromPhoneWithSortType(expectedType, completion: RecordsRetrievalCompletion)
        })
        
        waitForExpectationsWithTimeout(15) { (error: NSError?) -> Void in
            if (error != nil) {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    func testWhenCreatingATrack_ThenReadingTracksFromDeviceReturnsOneTrack() {
        testObject.deleteAllRecordsFromPhone()
        let expectation = expectationWithDescription("Grab Records")
        let expectedType = TRTrackingType.TrackAction
        let RecordsRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                print("✅ \(records)")
                XCTAssertEqual(records.count, 1)
                let expectedSortType = TRRecord.stringFromSortType(expectedType)
                XCTAssertEqual(records[0].itemType, expectedSortType)
                XCTAssertNotEqual(records[0].itemType, "anything")
            }
            expectation.fulfill()
        }
        
        testObject.createRecordWithItem("AnyItem", quantity: 1, itemType: expectedType, date: NSDate(), completion: {
            self.testObject.readTodaysRecordsFromPhoneWithSortType(expectedType, completion: RecordsRetrievalCompletion)
        })
        
        waitForExpectationsWithTimeout(15) { (error: NSError?) -> Void in
            if (error != nil) {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
}