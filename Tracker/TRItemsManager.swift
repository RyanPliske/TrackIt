import Foundation
import Parse

public class TRItemsManager : NSObject {
    var itemType: TRTrackingType
    var trackableItems = TRTrackableItems()
    private var recordService: TRRecordService
    public var tracks = [TRRecord]()
    var urges = [TRRecord]()
    
    init(sortType: TRTrackingType, recordService: TRRecordService) {
        self.itemType = sortType
        self.recordService = recordService
        super.init()
        grabTodaysTracks()
        grabTodaysUrges()
    }
    
    func grabTodaysTracks() {
        grabTodaysRecordsWithSortType(TRRecord.stringFromSortType(TRTrackingType.TrackAction))
    }
    
    func grabTodaysUrges() {
        grabTodaysRecordsWithSortType(TRRecord.stringFromSortType(TRTrackingType.TrackUrge))
    }
    
    private func grabTodaysRecordsWithSortType(sortType: String) {
        weak var weakSelf = self
        
        let RecordsRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                weakSelf?.tracks = records
            } else {
                print(error)
            }
        }
        
        self.recordService.readTodaysRecordsFromPhoneWithSortType(sortType, completion: RecordsRetrievalCompletion)
    }
}