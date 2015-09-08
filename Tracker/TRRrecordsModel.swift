import Foundation
import Parse

typealias TRCreateRecordCompletion = () -> Void
typealias TRSearchCompletion = () -> Void

class TRRecordsModel: NSObject {
    var recordService: TRRecordService
    var itemsManager: TRItemsManager
    var sortType: TRTrackingType {
        return self.itemsManager.itemSortType
    }
    var records: [TRRecord] {
        return self.itemsManager.records
    }
    var searchMode: Bool {
        return self.itemsManager.searchMode
    }
    
    init(recordService: TRRecordService) {
        self.recordService = recordService
        self.itemsManager = TRItemsManager(recordService: self.recordService)
        super.init()
    }
    
    func grabInitialData() {
        self.itemsManager.grabAllTracks()
        self.itemsManager.grabAllUrges()
    }
    
    func setSortTypeTo(sortType: TRTrackingType) {
        itemsManager.itemSortType = sortType
    }
    
    func setSearchModeTo(searchMode: Bool) {
        itemsManager.searchMode = searchMode
    }
    
    func trackItemAtRow(row: Int, quantityRow: Int, type: TRTrackingType, date: NSDate) {
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
    
    func untrack(record: TRRecord) {
        itemsManager.remove(record)
        recordService.deleteRecord(record)
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
