import Foundation

class TRTrackerPresenter: NSObject, TRItemsModelDelegate {
    let trackerView: TRTrackerView
    let recordsModel: TRRecordsModel
    lazy var itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    var dateToTrack = NSDate()
    var trackingType : TRRecordType = .TrackAction

    init(view: TRTrackerView, model: TRRecordsModel) {
        trackerView = view
        recordsModel = model
        super.init()
        self.trackerView.delegate = self
        self.trackerView.trackerTableView.dataSource = self
    }
    
    func itemOpenedStatusChangedAtIndex(index: Int) {
        trackerView.itemOpenedStatusChangedAtIndex(index)
    }
    
}
