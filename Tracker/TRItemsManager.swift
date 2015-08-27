import Foundation
import Parse

public class TRItemsManager : NSObject {
    internal var trackableItems = TRTrackableItems()
    internal var itemSortType = TRTrackingType.TrackAction
    internal var searchMode = false
    private var recordService: TRRecordService
    private var tracks = [TRRecord]()
    private var urges = [TRRecord]()
    private var searchResultsForTracks = [TRRecord]()
    private var searchResultsForUrges = [TRRecord]()
    public var records: [TRRecord] {
        if searchMode {
            switch (self.itemSortType) {
            case .TrackAction:
                return self.searchResultsForTracks
            case .TrackUrge:
                return self.searchResultsForUrges
            }
        } else {
            switch (self.itemSortType) {
            case .TrackAction:
                return self.tracks
            case .TrackUrge:
                return self.urges
            }
        }
    }
    
    public init(recordService: TRRecordService) {
        self.recordService = recordService
        super.init()
    }
    
    public func grabAllTracks() {
        grabRecordsWithSortType(TRTrackingType.TrackAction)
    }
    
    public func grabAllUrges() {
        grabRecordsWithSortType(TRTrackingType.TrackUrge)
    }
    
    func grabAllRecordsContaining(searchText: String, completion: TRSearchCompletion?) {
        searchMode = true
        if let completionBlock = completion {
            grabRecordsWithSearchText(searchText, sortType: .TrackAction, completion: nil)
            grabRecordsWithSearchText(searchText, sortType: .TrackUrge, completion: completionBlock)
        }
    }
    
    public func remove(record: TRRecord) {
        switch (self.itemSortType) {
        case .TrackAction:
            tracks = tracks.filter { $0 !== record }
            searchResultsForTracks = searchResultsForTracks.filter { $0 !== record }
        case .TrackUrge:
            urges = urges.filter { $0 !== record }
            searchResultsForUrges = searchResultsForUrges.filter { $0 !== record }
        }
    }
    
    // MARK: Helpers
    private func grabRecordsWithSortType(sortType: TRTrackingType) {
        weak var weakSelf = self
        let recordsRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                switch (sortType) {
                case .TrackAction:
                   weakSelf?.tracks = records
                case .TrackUrge:
                    weakSelf?.urges = records
                }
                
            } else {
                print(error)
            }
        }
        
        self.recordService.readAllRecordsFromPhoneWithSortType(sortType, completion: recordsRetrievalCompletion)
    }
    
    private func grabRecordsWithSearchText(searchText: String, sortType: TRTrackingType, completion: TRSearchCompletion?) {
        weak var weakSelf = self
        let recordsRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                switch (sortType) {
                case .TrackAction:
                    weakSelf?.searchResultsForTracks = records
                    print(records)
                    if let completionBlock = completion {
                        completionBlock()
                    }
                case .TrackUrge:
                    weakSelf?.searchResultsForUrges = records
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