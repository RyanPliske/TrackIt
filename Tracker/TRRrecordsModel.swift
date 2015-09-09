import Foundation
import Parse

typealias TRCreateRecordCompletion = () -> Void
typealias TRSearchCompletion = () -> Void

class TRRecordsModel: NSObject {
    var recordService: TRRecordService
    var recordTypeManager: TRRecordTypesManager
    
    var records: [TRRecord] {
        return self.recordTypeManager.records
    }
    var sortType: TRRecordType {
        return self.recordTypeManager.itemSortType
    }
    var searchMode: Bool {
        return self.recordTypeManager.searchMode
    }
    
    init(recordService: TRRecordService) {
        self.recordService = recordService
        self.recordTypeManager = TRRecordTypesManager(recordService: self.recordService)
        super.init()
    }
    
    func setSortTypeTo(sortType: TRRecordType) {
        recordTypeManager.itemSortType = sortType
    }
    
    func setSearchModeTo(searchMode: Bool) {
        recordTypeManager.searchMode = searchMode
    }
    
    func createRecordUsingRow(row: Int, quantityRow: Int, type: TRRecordType, date: NSDate) {
        var item: String
        if type == TRRecordType.TrackUrge {
            item = self.recordTypeManager.trackableItems.sinfulItems[row]
        } else {
            item = self.recordTypeManager.trackableItems.allItems[row]
        }
        
        let itemQuantity = self.quantityForRow(quantityRow)
        
        weak var weakSelf = self
        let blockCompletion: TRCreateRecordCompletion = {
            switch (type) {
            case .TrackAction:
                weakSelf?.recordTypeManager.grabAllTracks()
            case .TrackUrge:
                weakSelf?.recordTypeManager.grabAllUrges()
            }
        }
        
        recordService.createRecordWithItem(item, quantity: itemQuantity, itemType: type, date: date, completion: blockCompletion)
    }
    
    func readAllRecords() {
        self.recordTypeManager.grabAllTracks()
        self.recordTypeManager.grabAllUrges()
    }
    
    func searchRecordsFor(searchText: String, completion: TRSearchCompletion?) {
        if let completionBlock = completion {
            recordTypeManager.grabAllRecordsContaining(searchText, completion: completionBlock)
        }
    }
    
    func deleteRecordAtRow(record: TRRecord) {
        recordTypeManager.remove(record)
        recordService.deleteRecord(record)
    }
    
    // MARK: Private Helpers

    private func quantityForRow(row: Int) -> Int {
        return row + 1
    }
}
