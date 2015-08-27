import XCTest
import Parse
import Tracker

class TRItemsManagerTests: XCTestCase {
    let mockRecordService = MockRecordService()
    var testObject: TRItemsManager!
    
    override func setUp() {
        super.setUp()
        testObject = TRItemsManager(recordService: self.mockRecordService)
    }
    
    func testTracksArrayIsInitiallyEmpty() {
        testObject.itemSortType = .TrackAction
        XCTAssertTrue(testObject.records.isEmpty)
    }
    
    func testUrgesArrayIsEmpty() {
        testObject.itemSortType = .TrackUrge
        XCTAssertTrue(testObject.records.isEmpty)
    }
    
    func testWhenGrabingTodaysTracks_ThenTracksIsNotEmpty() {
        testObject.grabTodaysTracks()
        testObject.itemSortType = .TrackUrge
        XCTAssert(testObject.records.isEmpty)
        testObject.itemSortType = .TrackAction
        XCTAssert(!testObject.records.isEmpty)
    }
    
    func testWhenGrabbingTodaysUrges_ThenUrgesIsNotEmpty() {
        testObject.grabTodaysUrges()
        testObject.itemSortType = .TrackAction
        XCTAssert(testObject.records.isEmpty)
        testObject.itemSortType = .TrackUrge
        XCTAssert(!testObject.records.isEmpty)
    }
}