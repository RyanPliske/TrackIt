import Foundation
import Parse

typealias TRCreateRecordCompletion = () -> Void
typealias TRSearchCompletion = () -> Void
typealias TRSearchForItemCompletion = ([TRRecord]?, NSError?) -> Void
typealias TRTracks = [Int : Float]
typealias TRRecordedDays = (days: [Int], dailyGoalType: DailyGoalType)

class TRRecordsModel {
    
    static let sharedInstanceOfRecordsModel = TRRecordsModel(recordService: TRRecordService(), itemsModel: TRItemsModel.sharedInstanceOfItemsModel)

    private let recordSortManager = TRRecordSortManager()
    private let recordService: TRRecordService
    private let itemsModel: TRItemsModel
    

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
    

    init(recordService: TRRecordService, itemsModel: TRItemsModel) {
        self.recordService = recordService
        self.itemsModel = itemsModel
        TRRecord()
    }
    
    func createRecordUsingRow(row: Int, quantity: Float, type: TRRecordType, date: NSDate) {
        var item: String
        switch (type) {
        case .TrackAction:
            item = itemsModel.activeItems[row].name
        case .TrackUrge:
            item = itemsModel.activeItems[row].name
        }
        
        weak var weakSelf = self
        let blockCompletion: TRCreateRecordCompletion = {
            switch (type) {
            case .TrackAction:
                weakSelf?.grabAllTracks(nil)
            case .TrackUrge:
                weakSelf?.grabAllUrges(nil)
            }
        }
        
        recordService.createRecordWithItem(item, quantity: quantity, itemType: type, date: date, completion: blockCompletion)
    }
    
    func readAllRecords(completion: TRSearchCompletion?) {
        weak var weakSelf = self
        grabAllTracks { () -> Void in
            weakSelf?.grabAllUrges({ () -> Void in
                if let completionBlock = completion {
                    completionBlock()
                }
            })
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
    
    func recordedDaysForItem(item: TRItem, forDate date: NSDate, withGoal goal: Int, forGoalType goalType: DailyGoalType) -> TRRecordedDays {
        guard let tracks = tracksForItem(item, forDate: date) else {
            return ([], goalType)
        }
        var failureDays = [Int]()
        var successDays = [Int]()
        switch (goalType) {
        case .Max:
            for (indexOfDay, count) in tracks {
                if Int(count) > goal {
                    failureDays.append(indexOfDay)
                } else {
                    successDays.append(indexOfDay)
                }
            }
        case .Min:
            for (indexOfDay, count) in tracks {
                if Int(count) < goal {
                    failureDays.append(indexOfDay)
                } else {
                    successDays.append(indexOfDay)
                }
            }
        }
        if goalType == DailyGoalType.Max {
            return (failureDays, goalType)
        } else {
            return (successDays, goalType)
        }
    }
    
    func deleteRecordAtRow(record: TRRecord) {
        recordSortManager.removeRecord(record)
        recordService.deleteRecord(record)
    }
    
    // MARK: Private Helpers
    private func tracksForItem(item: TRItem, forDate date: NSDate) -> TRTracks? {
        var records = recordService.readAllRecordsFromPhoneWithItemName(item.name, monthName: TRDateFormatter.monthOfDate(date), yearName: TRDateFormatter.yearOfDate(date))
        if records.isEmpty {
            return nil
        }
        var tracks = TRTracks()
        for record in records {
            let indexOfDay: Int = TRDateFormatter.dayOfDate(record.date!)
            let quantitiesForDay = records.filter { TRDateFormatter.dayOfDate($0.date!) ==  indexOfDay }.map { $0.itemQuantity }
            let sumForDay = quantitiesForDay.reduce(0, combine: +)
            tracks[indexOfDay] = sumForDay
            records = records.filter { TRDateFormatter.dayOfDate($0.date!) != indexOfDay }
            if records.isEmpty {
                break
            }
        }
        return tracks
    }
    
    private func grabAllTracks(completion: TRSearchCompletion?) {
        grabRecordsWithSortType(TRRecordType.TrackAction, completion: completion)
    }
    
    private func grabAllUrges(completion: TRSearchCompletion?) {
        grabRecordsWithSortType(TRRecordType.TrackUrge, completion: completion)
    }
    
    private func grabRecordsWithSortType(sortType: TRRecordType, completion: TRSearchCompletion?) {
        weak var weakSelf = self
        let recordsRetrievalCompletion: PFQueryArrayResultBlock = {
            (objects: [PFObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                switch (sortType) {
                case .TrackAction:
                    weakSelf?.recordSortManager.tracks = records
                    if let completionBlock = completion {
                        completionBlock()
                    }
                case .TrackUrge:
                    weakSelf?.recordSortManager.urges = records
                    if let completionBlock = completion {
                        completionBlock()
                    }
                }
                
            } else {
                switch (sortType) {
                case .TrackAction:
                    weakSelf?.grabAllTracks(nil)
                case .TrackUrge:
                    weakSelf?.grabAllUrges(nil)
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
        let recordsRetrievalCompletion: PFQueryArrayResultBlock = {
            (objects: [PFObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                switch (sortType) {
                case .TrackAction:
                    weakSelf?.recordSortManager.searchResultsForTracks = records
                    if let completionBlock = completion {
                        completionBlock()
                    }
                case .TrackUrge:
                    weakSelf?.recordSortManager.searchResultsForUrges = records
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
