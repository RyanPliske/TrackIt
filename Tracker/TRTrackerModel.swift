import Foundation
import Parse

public typealias TRCreateRecordCompletion = () -> Void

public class TRTrackerModel: NSObject {
    var recordService: TRRecordService
    public var itemsManager: TRItemsManager
    
    public init(recordService: TRRecordService) {
        self.recordService = recordService
        self.itemsManager = TRItemsManager(recordService: self.recordService)
        super.init()
        self.itemsManager.grabTodaysTracks()
        self.itemsManager.grabTodaysUrges()
    }
    
    public func trackItemAtRow(row: Int, quantityRow: Int, type: TRTrackingType, date: NSDate) {
        var item: String
        if type == TRTrackingType.TrackUrge {
            item = self.itemsManager.trackableItems.sinfulItems[row]
        } else {
            item = self.itemsManager.trackableItems.allItems[row]
        }
        let itemQuantity = self.quantityForRow(quantityRow)
        
        weak var weakSelf = self
        let blockCompletion: TRCreateRecordCompletion = {
            switch (type) {
                case .TrackAction:
                    weakSelf?.itemsManager.grabTodaysTracks()
                case .TrackUrge:
                    weakSelf?.itemsManager.grabTodaysUrges()
            }
        }
        
        self.recordService.createRecordWithItem(item, quantity: itemQuantity, itemType: type, date: date, completion: blockCompletion)
    }
    
    func setSortType(sortType: TRTrackingType) {
        itemsManager.itemType = sortType
    }

    private func quantityForRow(row: Int) -> Int {
        return row + 1
    }
}
