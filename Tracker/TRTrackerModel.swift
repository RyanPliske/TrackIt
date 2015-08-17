import Foundation

class TRTrackerModel: NSObject {
    var trackableItems = TRTrackableItems()
    var records = [PFObject]()
    var recordService = TRRecordService()
    
    func trackItemAtRow(row: Int, quantityRow: Int, type: TRTrackingType) {
        var item: String
        if type == TRTrackingType.TrackUrge {
            item = self.trackableItems.sinfulItems[row]
        } else {
            item = self.trackableItems.allItems[row]
        }
        let itemQuantity = self.quantityForRow(quantityRow)
        let record = self.recordService.createRecordWithItem(item, quantity: itemQuantity, itemType: type)
        records.append(record)
    }
    
    private func quantityForRow(row: Int) -> Int {
        return row + 1
    }
}
