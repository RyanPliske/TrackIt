import Foundation

class TRTrackerModel: NSObject {
    var trackableItems: TRTrackableItems
    
    override init() {
        trackableItems = TRTrackableItems()
        super.init()
    }
    
    func userPickedItemAtRow(row: Int, quantityRow: Int) {
        // Create a Record with Item and quantity
        
        // Save record to phone
    }
}
