import UIKit
import Parse

typealias TRCreateRecordCompletion = () -> Void
typealias TRSearchCompletion = () -> Void
typealias TRSearchForItemCompletion = ([TRRecord]?, NSError?) -> Void
typealias TRTrack = (dayIndex: Int, count: Float)
typealias TRTracks = [TRTrack]
typealias TRRecordedDays = (days: [Int], dailyGoalType: DailyGoalType)

protocol TRRecordsModelDelegate: class {
    func recordsChangedWithName(name: String)
}

class TRRecordsModel {
    
    static let sharedInstanceOfRecordsModel = TRRecordsModel(recordService: TRRecordService(), itemsModel: TRItemsModel.sharedInstanceOfItemsModel)
    weak var delegate: TRRecordsModelDelegate!

    var records: [TRRecord] {
        get { return self.recordSortManager.records }
    }
    var searchMode: Bool {
        get { return self.recordSortManager.searchMode }
        set { self.recordSortManager.searchMode = newValue }
    }
    
    private let recordSortManager = TRRecordSortManager()
    private let recordService: TRRecordService
    private let itemsModel: TRItemsModel

    init(recordService: TRRecordService, itemsModel: TRItemsModel) {
        self.recordService = recordService
        self.itemsModel = itemsModel
        TRRecord()
    }
    
    func createRecordUsingRow(row: Int, quantity: Float, date: NSDate, withCompletion completion: TRCreateRecordCompletion) {
        let item = itemsModel.activeItems[row].name
        let blockCompletion: TRCreateRecordCompletion = {
            [weak self] in
            self?.grabAllTracks(nil)
            completion()
        }
        recordService.createRecordWithItem(item, quantity: quantity, date: date, completion: blockCompletion)
    }
    
    func readAllRecords(completion: TRSearchCompletion?) {
        weak var weakSelf = self
        grabAllTracks { () -> Void in
            completion?()
        }
        
    }
    
    func searchRecordsForItem(itemName: String, dateDescription: String, completion: TRSearchForItemCompletion) {
        recordService.readAllRecordsFromPhoneWithItemName(itemName, dateDescription: dateDescription, completion: completion)
    }
    
    func searchRecordsForItem(itemName: String, completion: TRSearchForItemCompletion) {
        recordService.readAllRecordsFromPhoneWithItemName(itemName, completion: completion)
    }
    
    func searchRecordsFor(searchText: String, completion: TRSearchCompletion?) {
        if let completionBlock = completion {
            grabAllRecordsContaining(searchText, completion: completionBlock)
        }
    }
    
    func tracksForItem(item: TRItem, forDate date: NSDate) -> TRTracks {
        var records = recordService.readAllRecordsFromPhoneWithItemName(item.name, monthName: TRDateFormatter.monthOfDate(date), yearName: TRDateFormatter.yearOfDate(date))
        if records.isEmpty {
            return []
        }
        var tracks = TRTracks()
        for var index = records.count - 1; index >= 0; --index {
            let indexOfDay: Int = TRDateFormatter.dayOfDate(records[index].date!)
            let quantitiesForDay = records.filter { TRDateFormatter.dayOfDate($0.date!) ==  indexOfDay }.map { $0.itemQuantity }
            let sumForDay = quantitiesForDay.reduce(0, combine: +)
            let track: TRTrack = (dayIndex: indexOfDay, count: sumForDay)
            tracks.append(track)
            records = records.filter { TRDateFormatter.dayOfDate($0.date!) != indexOfDay }
            index = records.count
        }
        return tracks
    }
    
    func deleteRecordAtRow(record: TRRecord) {
        recordSortManager.removeRecord(record)
        recordService.deleteRecord(record)
        delegate.recordsChangedWithName(record.itemName!)
    }
    
    // MARK: Private Helpers
    private func grabAllTracks(completion: TRSearchCompletion?) {
        grabRecords(completion)
    }
    
    private func grabRecords(completion: TRSearchCompletion?) {
        weak var weakSelf = self
        let recordsRetrievalCompletion: PFQueryArrayResultBlock = {
            (objects: [PFObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                weakSelf?.recordSortManager.tracks = records
                completion?()
            } else {
                weakSelf?.grabAllTracks(nil)
            }
        }
        
        recordService.readAllRecordsFromPhone(recordsRetrievalCompletion)
    }
    
    private func grabAllRecordsContaining(searchText: String, completion: TRSearchCompletion?) {
        recordSortManager.searchMode = true
        if let completionBlock = completion {
            grabRecordsWithSearchText(searchText, completion: completionBlock)
        }
    }
    
    private func grabRecordsWithSearchText(searchText: String, completion: TRSearchCompletion?) {
        weak var weakSelf = self
        let recordsRetrievalCompletion: PFQueryArrayResultBlock = {
            (objects: [PFObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                weakSelf?.recordSortManager.searchResultsForTracks = records
                completion?()
            } else {
                print(error)
            }
        }
        recordService.readAllRecordsFromPhoneWithSearchText(searchText, completion: recordsRetrievalCompletion)
    }
}
