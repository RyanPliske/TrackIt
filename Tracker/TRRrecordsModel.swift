import Foundation
import Parse

typealias TRCreateRecordCompletion = () -> Void
typealias TRSearchCompletion = () -> Void

class TRRecordsModel: NSObject {
    // MARK: Private Variables
    private var recordSortManager = TRRecordSortManager()
    private var recordService: TRRecordService
    
    // MARK: Public Variables
    var trackableItems = TRTrackableItems()
    var records: [TRRecord] {
        return self.recordSortManager.records
    }
    var sortType: TRRecordType {
        return self.recordSortManager.sortType
    }
    var searchMode: Bool {
        return self.recordSortManager.searchMode
    }
    
    // MARK: Public Methods
    init(recordService: TRRecordService) {
        self.recordService = recordService
        super.init()
    }
    
    func setSortTypeTo(sortType: TRRecordType) {
        recordSortManager.sortType = sortType
    }
    
    func setSearchModeTo(searchMode: Bool) {
        recordSortManager.searchMode = searchMode
    }
    
    func createRecordUsingRow(row: Int, quantityRow: Int, type: TRRecordType, date: NSDate) {
        var item: String
        if type == TRRecordType.TrackUrge {
            item = trackableItems.sinfulItems[row]
        } else {
            item = trackableItems.allItems[row]
        }
        
        let itemQuantity = quantityForRow(quantityRow)
        
        weak var weakSelf = self
        let blockCompletion: TRCreateRecordCompletion = {
            switch (type) {
            case .TrackAction:
                weakSelf?.grabAllTracks()
            case .TrackUrge:
                weakSelf?.grabAllUrges()
            }
        }
        
        recordService.createRecordWithItem(item, quantity: itemQuantity, itemType: type, date: date, completion: blockCompletion)
    }
    
    func readAllRecords() {
        grabAllTracks()
        grabAllUrges()
    }
    
    func searchRecordsFor(searchText: String, completion: TRSearchCompletion?) {
        if let completionBlock = completion {
            grabAllRecordsContaining(searchText, completion: completionBlock)
        }
    }
    
    func deleteRecordAtRow(record: TRRecord) {
        recordSortManager.removeRecord(record)
        recordService.deleteRecord(record)
    }
    
    // MARK: Private Helpers
    private func quantityForRow(row: Int) -> Int {
        return row + 1
    }
    
    private func grabAllTracks() {
        grabRecordsWithSortType(TRRecordType.TrackAction)
    }
    
    private func grabAllUrges() {
        grabRecordsWithSortType(TRRecordType.TrackUrge)
    }
    
    private func grabRecordsWithSortType(sortType: TRRecordType) {
        weak var weakSelf = self
        let recordsRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                switch (sortType) {
                case .TrackAction:
                    weakSelf?.recordSortManager.tracks = records
                case .TrackUrge:
                    weakSelf?.recordSortManager.urges = records
                }
                
            } else {
                switch (sortType) {
                case .TrackAction:
                    weakSelf?.grabAllTracks()
                case .TrackUrge:
                    weakSelf?.grabAllUrges()
                }
            }
        }
        
        recordService.readAllRecordsFromPhoneWithSortType(sortType, completion: recordsRetrievalCompletion)
    }
    
    private func grabAllRecordsContaining(searchText: String, completion: TRSearchCompletion?) {
        recordSortManager.searchMode = true
        if let completionBlock = completion {
            grabRecordsWithSearchText(searchText, sortType: .TrackAction, completion: nil)
            grabRecordsWithSearchText(searchText, sortType: .TrackUrge, completion: completionBlock)
        }
    }
    
    private func grabRecordsWithSearchText(searchText: String, sortType: TRRecordType, completion: TRSearchCompletion?) {
        weak var weakSelf = self
        let recordsRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                switch (sortType) {
                case .TrackAction:
                    weakSelf?.recordSortManager.searchResultsForTracks = records
                    print(records)
                    if let completionBlock = completion {
                        completionBlock()
                    }
                case .TrackUrge:
                    weakSelf?.recordSortManager.searchResultsForUrges = records
                    print(records)
                    if let completionBlock = completion {
                        completionBlock()
                    }
                }
            } else {
                print(error)
            }
        }
        
        recordService.readAllRecordsFromPhoneWithSearchText(searchText, sortType: sortType, completion: recordsRetrievalCompletion)
    }
}
