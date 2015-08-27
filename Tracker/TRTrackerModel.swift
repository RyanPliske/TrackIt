import Foundation
import Parse

public typealias TRCreateRecordCompletion = () -> Void
public typealias TRSearchCompletion = () -> Void

public class TRTrackerModel: NSObject {
    var recordService: TRRecordService
    public var itemsManager: TRItemsManager
    public var sortType: TRTrackingType {
        return self.itemsManager.itemSortType
    }
    public var records: [TRRecord] {
        return self.itemsManager.records
    }
    
    public init(recordService: TRRecordService) {
        self.recordService = recordService
        self.itemsManager = TRItemsManager(recordService: self.recordService)
        super.init()
        self.itemsManager.grabAllTracks()
        self.itemsManager.grabAllUrges()
    }
    
    func setSortType(sortType: TRTrackingType) {
        itemsManager.itemSortType = sortType
    }
    
    public func trackItemAtRow(row: Int, quantityRow: Int, type: TRTrackingType, date: NSDate) {
        var item: String
        if type == TRTrackingType.TrackUrge {
            item = self.itemsManager.trackableItems.sinfulItems[row]
        } else {
            item = self.itemsManager.trackableItems.allItems[row]
        }
        let itemQuantity = self.quantityForRow(quantityRow)
        
        weak var weakSelf = self
        let blockCompletion: TRCreateRecordCompletion = {
            switch (type) {
                case .TrackAction:
                    weakSelf?.itemsManager.grabAllTracks()
                case .TrackUrge:
                    weakSelf?.itemsManager.grabAllUrges()
            }
        }
        
        recordService.createRecordWithItem(item, quantity: itemQuantity, itemType: type, date: date, completion: blockCompletion)
    }
    
    public func untrack(record: TRRecord) {
        recordService.deleteRecord(record)
        itemsManager.remove(record)
    }
    
    func searchRecordsFor(searchText: String, completion: TRSearchCompletion?) {
        if let completionBlock = completion {
            itemsManager.grabAllRecordsContaining(searchText, completion: completionBlock)
        }
    }

    private func quantityForRow(row: Int) -> Int {
        return row + 1
    }
}
