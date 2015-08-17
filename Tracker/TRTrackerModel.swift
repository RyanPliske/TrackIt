import Foundation

class TRTrackerModel: NSObject {
    var trackableItems: TRTrackableItems
    var recordToTrack: PFObject?
    var recordServices: RecordServices
    
    override init() {
        trackableItems = TRTrackableItems()
        recordServices = RecordServices()
        super.init()
    }
    
    func trackItemAtRow(row: Int, quantityRow: Int, type: TRTrackingType) {
        var item: String
        if type == TRTrackingType.TrackUrge {
            item = self.trackableItems.sinfulItems[row]
        } else {
            item = self.trackableItems.allItems[row]
        }
        let itemQuantity = self.quantityForRow(quantityRow)
        recordToTrack = self.recordWithItem(item, quantity: itemQuantity, itemType: type)
    }

    // MARK: Helper Methods
    private func recordWithItem(item: String, quantity: Int, itemType: TRTrackingType) -> PFObject {
        let record = PFObject(className: "record")
        record["item"] = item
        record["quantity"] = quantity
        let type = (itemType == TRTrackingType.TrackAction) ? "action" : "urge"
        record["type"] = type
        return record
    }
    
    private func quantityForRow(row: Int) -> Int {
        return row + 1
    }
}
