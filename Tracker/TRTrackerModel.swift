import Foundation

class TRTrackerModel: NSObject {
    var trackableItems: TRTrackableItems
    
    override init() {
        trackableItems = TRTrackableItems()
        super.init()
    }
    
}
