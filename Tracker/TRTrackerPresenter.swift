import Foundation
import JTCalendar

protocol TRTrackerPresenterDelegate: class {
    func addChildViewControllerWith(viewController: UIPageViewController)
}

class TRTrackerPresenter: NSObject {
    let trackerView: TRTrackerView
    let recordsModel: TRRecordsModel
    lazy var itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    var dateToTrack = NSDate()
    var trackingType : TRRecordType = .TrackAction
    var pageViewControllers: [UIPageViewController]?
    weak var delegate: TRTrackerPresenterDelegate?
    
    var _modelController: TRTrackerPageViewDataSource?

    init(view: TRTrackerView, model: TRRecordsModel) {
        trackerView = view
        recordsModel = model
        super.init()
        self.trackerView.delegate = self
        self.trackerView.trackerTableView.dataSource = self
    }
    
}
