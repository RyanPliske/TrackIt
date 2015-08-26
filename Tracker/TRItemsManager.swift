import Foundation
import Parse

public class TRItemsManager : NSObject {
    var itemSortType = TRTrackingType.TrackAction
    var trackableItems = TRTrackableItems()
    private var recordService: TRRecordService
    public var tracks = [TRRecord]()
    public var urges = [TRRecord]()
    
    public init(recordService: TRRecordService) {
        self.recordService = recordService
        super.init()
    }
    
    public func grabTodaysTracks() {
        grabTodaysRecordsWithSortType(TRTrackingType.TrackAction)
    }
    
    public func grabTodaysUrges() {
        grabTodaysRecordsWithSortType(TRTrackingType.TrackUrge)
    }
    
    private func grabTodaysRecordsWithSortType(sortType: TRTrackingType) {
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
        
        self.recordService.readTodaysRecordsFromPhoneWithSortType(sortType, completion: RecordsRetrievalCompletion)
    }
}