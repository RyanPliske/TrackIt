import Foundation
import Parse

public class TRTrackerModel: NSObject {
    var trackableItems = TRTrackableItems()
    public var records = [TRRecord]()
    var recordService: TRRecordService
    
    public init(recordService: TRRecordService) {
        self.recordService = recordService
        super.init()
        self.grabRecords()
    }
    
    func trackItemAtRow(row: Int, quantityRow: Int, type: TRTrackingType, date: NSDate) {
        var item: String
        if type == TRTrackingType.TrackUrge {
            item = self.trackableItems.sinfulItems[row]
        } else {
            item = self.trackableItems.allItems[row]
        }
        let itemQuantity = self.quantityForRow(quantityRow)
        self.recordService.createRecordWithItem(item, quantity: itemQuantity, itemType: type, date: date)
    }
    
    func grabRecords() -> [TRRecord]? {
        weak var weakSelf = self
        let RecordsRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                weakSelf?.records = records
            } else {
                print(error)
            }
        }
        
        self.recordService.readRecordsFromPhone(RecordsRetrievalCompletion)
        return self.records
    }
    
    private func quantityForRow(row: Int) -> Int {
        return row + 1
    }
}
