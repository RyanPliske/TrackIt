import UIKit
import QuartzCore
import MMDrawerController

class TRTrackerViewController: UIViewController, TRTrackerViewObserver {
    
    var recordsModel: TRRecordsModel!
    var itemsModel: TRItemsModel!
    
    @IBOutlet private weak var trackerView: TRTrackerView!
    private var trackerPresenter: TRTrackerPresenter!
    private var recordService = TRRecordService()
    @IBOutlet private weak var activityMonitor: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordsModel.readAllRecords(nil)
        trackerPresenter = TRTrackerPresenter(view: trackerView, recordsModel: recordsModel, itemsModel: itemsModel)
        activityMonitor.startAnimating()
        trackerView.observer = self
        itemsModel.delegate = trackerPresenter
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemRetrievalObserved", name: "itemsRetrievedFromDB", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemsChanged", name: "ActiveItemsChanged", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        trackerView.trackerTableView.reloadData()
    }
    
    //MARK: NSNotificationCenter
    
    func itemsChanged() {
        trackerView.trackerTableView.reloadData()
    }
    
    func itemRetrievalObserved() {
        activityMonitor.stopAnimating()
        activityMonitor.hidden = true
        trackerView.trackerTableView.reloadData()

    }
    
    //MARK: Actions
    
    @IBAction func settingsButtonPressed(sender: AnyObject) {
        mm_drawerController.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: nil)
    }
    
}