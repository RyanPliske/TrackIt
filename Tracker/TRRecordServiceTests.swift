import XCTest

class TRRecordServiceTests : XCTestCase {
    let testObject = TRRecordService()
    
    override func setUp() {
        testObject.deleteAllRecordsFromPhone()
    }
}