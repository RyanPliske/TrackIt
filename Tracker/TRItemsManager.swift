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
    
    func grabAllRecordsContaining(searchText: String) {
        grabRecordsWithSearchText(searchText)
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
        
        let RecordsRetrievalCompletion: PFArrayResultBlock = {
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
        
        self.recordService.readAllRecordsFromPhoneWithSortType(sortType, completion: RecordsRetrievalCompletion)
    }
    
    private func grabRecordsWithSearchText(searchText: String) {
        recordService.readAllRecordsFromPhoneWithSearchText(searchText, sortType: TRTrackingType.TrackAction, completion: nil)
        recordService.readAllRecordsFromPhoneWithSearchText(searchText, sortType: TRTrackingType.TrackUrge, completion: nil)
    }
}