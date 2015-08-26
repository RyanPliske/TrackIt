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
        XCTAssertTrue(testObject.tracks.isEmpty)
    }
    
    func testUrgesArrayIsEmpty() {
        XCTAssertTrue(testObject.urges.isEmpty)
    }
    
    func testWhenGrabingTodaysTracks_ThenTracksIsNotEmpty() {
        testObject.grabTodaysTracks()
        XCTAssert(!testObject.tracks.isEmpty)
        XCTAssert(testObject.urges.isEmpty)
        testObject.tracks.removeAll()
    }
    
    func testWhenGrabbingTodaysUrges_ThenUrgesIsNotEmpty() {
        testObject.grabTodaysUrges()
        XCTAssert(!testObject.urges.isEmpty)
        XCTAssert(testObject.tracks.isEmpty)
        testObject.urges.removeAll()
    }
}