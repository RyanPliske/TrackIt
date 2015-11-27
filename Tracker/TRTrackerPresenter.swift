import Foundation

class TRTrackerPresenter: NSObject, TRItemsModelDelegate, TRRecordsModelDelegate {
    let trackerView: TRTrackerView
    let recordsModel: TRRecordsModel
    lazy var itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    var dateToTrack = NSDate()
    var trackingType : TRRecordType = .TrackAction

    init(view: TRTrackerView, model: TRRecordsModel) {
        trackerView = view
        recordsModel = model
        super.init()
        self.recordsModel.delegate = self
        self.trackerView.delegate = self
        self.trackerView.trackerTableView.dataSource = self
    }
    
    //MARK: - TRItemsModelDelegate
    
    func itemOpenedStatusChangedAtIndex(index: Int) {
        trackerView.itemOpenedStatusChangedAtIndex(index)
    }
    
    func itemTrackByOneStatusChangedAtIndex(index: Int) {
        trackerView.trackerTableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: index)], withRowAnimation: .None)
    }
    
    //MARK: - TRRecordsModelDelegate
    
    func recordsChangedWithName(name: String) {
        let filter = itemsModel.activeItems.filter { $0.name == name }.first!
        let index = itemsModel.activeItems.indexOf(filter)!
        trackerView.trackerTableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: index)], withRowAnimation: .None)
    }
    
}
