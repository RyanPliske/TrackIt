import Foundation
import Parse

public class TRItemsManager : NSObject {
    internal var trackableItems = TRTrackableItems()
    private var recordService: TRRecordService
    private var tracks = [TRRecord]()
    private var urges = [TRRecord]()
    internal var itemSortType = TRTrackingType.TrackAction
    public var records: [TRRecord] {
        switch (self.itemSortType) {
        case .TrackAction:
            return self.tracks
        case .TrackUrge:
            return self.urges
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
        if let completionBlock = completion {
            grabRecordsWithSearchText(searchText, sortType: .TrackAction, completion: completionBlock)
            grabRecordsWithSearchText(searchText, sortType: .TrackUrge, completion: completionBlock)
        }
    }
    
    public func remove(record: TRRecord) {
        switch (self.itemSortType) {
        case .TrackAction:
            tracks = tracks.filter() { $0 !== record}
        case .TrackUrge:
            urges = urges.filter() { $0 !== record}
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
                if let completionBlock = completion {
                    switch (sortType) {
                    case .TrackAction:
                        weakSelf?.tracks = records
                        completionBlock()
                    case .TrackUrge:
                        weakSelf?.urges = records
                        completionBlock()
                    }
                }
                
            } else {
                print(error)
            }
        }
        
        recordService.readAllRecordsFromPhoneWithSearchText(searchText, sortType: TRTrackingType.TrackAction, completion: recordsRetrievalCompletion)
    }
}