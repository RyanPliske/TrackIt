import Foundation
import Parse

public typealias TRCreateRecordCompletion = () -> Void

public class TRTrackerModel: NSObject {
    var trackableItems = TRTrackableItems()
    public var records = [TRRecord]()
    var recordService: TRRecordService
    
    public init(recordService: TRRecordService) {
        self.recordService = recordService
        super.init()
        self.grabAllOfTodaysRecords()
    }
    
    func trackItemAtRow(row: Int, quantityRow: Int, type: TRTrackingType, date: NSDate) {
        var item: String
        if type == TRTrackingType.TrackUrge {
            item = self.trackableItems.sinfulItems[row]
        } else {
            item = self.trackableItems.allItems[row]
        }
        let itemQuantity = self.quantityForRow(quantityRow)
        
        let blockCompletion: TRCreateRecordCompletion = {
            self.grabAllOfTodaysRecords()
        }
        
        self.recordService.createRecordWithItem(item, quantity: itemQuantity, itemType: type, date: date, completion: blockCompletion)
    }
    
    private func grabAllOfTodaysRecords() {
        weak var weakSelf = self
        
        let RecordsRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                weakSelf?.records = records
            } else {
                print(error)
            }
        }
        
        self.recordService.readTodaysRecordsFromPhone(RecordsRetrievalCompletion)
    }
    
    private func quantityForRow(row: Int) -> Int {
        return row + 1
    }
}
