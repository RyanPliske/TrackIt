import Foundation
import Parse
import Tracker

class MockRecord: TRRecord {
    
    override internal class func initialize() {
    }
    
    override func pinInBackgroundWithBlock(block: PFBooleanResultBlock?) {
        if let blockCompletion = block {
            blockCompletion(true, nil)
        }
    }
    
}