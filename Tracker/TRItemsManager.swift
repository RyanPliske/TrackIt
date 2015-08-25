import Foundation
import Parse

public class TRItemsManager : NSObject {
    var sortType: TRTrackingType
    var trackableItems = TRTrackableItems()
    private var recordService: TRRecordService
    public var tracks = [TRRecord]()
    var urges = [TRRecord]()
    
    init(sortType: TRTrackingType, recordService: TRRecordService) {
        self.sortType = sortType
        self.recordService = recordService
        super.init()
        grabTodaysTracks()
        grabTodaysUrges()
    }
    
    func grabTodaysTracks() {
        weak var weakSelf = self
        
        let RecordsRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let records = objects as? [TRRecord] {
                weakSelf?.tracks = records
            } else {
                print(error)
            }
        }
        
        self.recordService.readTodaysRecordsFromPhone(RecordsRetrievalCompletion)
    }
    
    func grabTodaysUrges() {
        
    }
}