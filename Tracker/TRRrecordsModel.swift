import Foundation
import Parse

typealias TRCreateRecordCompletion = () -> Void
typealias TRSearchCompletion = () -> Void

class TRRecordsModel {
    
    static let sharedInstanceOfRecordsModel = TRRecordsModel(recordService: TRRecordService(), itemsModel: TRItemsModel.sharedInstanceOfItemsModel)
    // MARK: Private Properties
    private let recordSortManager = TRRecordSortManager()
    private let recordService: TRRecordService
    private let itemsModel: TRItemsModel
    
    // MARK: Public Properties
    var records: [TRRecord] {
        get { return self.recordSortManager.records }
    }
    var sortType: TRRecordType {
        get { return self.recordSortManager.sortType }
        set { self.recordSortManager.sortType = newValue }
    }
    var searchMode: Bool {
        get { return self.recordSortManager.searchMode }
        set { self.recordSortManager.searchMode = newValue }
    }
    
    // MARK: Public Methods
    init(recordService: TRRecordService, itemsModel: TRItemsModel) {
        self.recordService = recordService
        self.itemsModel = itemsModel
        TRRecord()
        self.readAllRecords()
    }
    
    func createRecordUsingRow(row: Int, quantityRow: Int, type: TRRecordType, date: NSDate) {
        var item: String
        switch (type) {
        case .TrackAction:
            item = itemsModel.activeItems[row].name
        case .TrackUrge:
            item = itemsModel.activeSinfulItems[row].name
        }
        
        let itemQuantity = quantityRow + 1
        
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
