import UIKit
import QuartzCore
import MMDrawerController

class TRTrackerViewController: UIViewController, TRTrackerViewObserver {
    
    var _navigationController: UINavigationController?
    
    @IBOutlet private weak var trackerView: TRTrackerView!
    private var trackerPresenter: TRTrackerPresenter!
    private var recordService = TRRecordService()
    private lazy var recordsModel = TRRecordsModel.sharedInstanceOfRecordsModel
    private lazy var itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TRRecordsModel.sharedInstanceOfRecordsModel.readAllRecords(nil)
        trackerPresenter = TRTrackerPresenter(view: self.trackerView, model: self.recordsModel)
        activityMonitor.startAnimating()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemRetrievalObserved", name: "itemsRetrievedFromDB", object: nil)
        setNeedsStatusBarAppearanceUpdate()
        trackerView.observer = self
        _navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir", size: 25.0)!]
        _navigationController?.navigationBar.tintColor = UIColor.TRMimosaYellow()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemsChanged", name: "ActiveItemsChanged", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        trackerView.trackerTableView.reloadData()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    func itemsChanged() {
        trackerView.trackerTableView.reloadData()
    }
    
    func itemRetrievalObserved() {
        activityMonitor.stopAnimating()
        activityMonitor.hidden = true
        trackerView.trackerTableView.reloadData()

    }
    
    @IBAction func settingsButtonPressed(sender: AnyObject) {
        mm_drawerController.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: nil)
    }
    
    // MARK: TRTrackerViewObserver
    func dateChooserWanted() {
        let dateViewController = TRChooseableDateViewController(dateToSelect: trackerPresenter.dateToTrack)
        dateViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
        dateViewController.dateObserver = self.trackerPresenter
        if let popOver = dateViewController.popoverPresentationController {
            popOver.permittedArrowDirections = UIPopoverArrowDirection.Up
            popOver.delegate = dateViewController
            popOver.sourceView = self.trackerView
            popOver.sourceRect = self.trackerView.todaysDateButton.frame
            self.presentViewController(dateViewController, animated: true, completion: nil)
        }
    }
    
    func trackingOptionsWantedAtRow(row: Int, includeBadHabit: Bool) {
        let incrementByOne = itemsModel.activeItems[row].incrementByOne
        let trackingOptionsTableViewController = TRTrackingOptionsTableViewController(
            associatedItemIsAVice: includeBadHabit,
            associatedItemIncrementsByOne: incrementByOne,
            associatedItemRow: row)
        trackingOptionsTableViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
        if let popOver = trackingOptionsTableViewController.popoverPresentationController {
            popOver.permittedArrowDirections = .Right
            popOver.delegate = trackingOptionsTableViewController
            if let cell = trackerView.trackerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: row)) as? TRTrackerTableViewCell {
                popOver.sourceView = cell.contentView
                popOver.sourceRect = cell.moreButtonFrame
                trackingOptionsTableViewController.delegate = cell
            }
            self.presentViewController(trackingOptionsTableViewController, animated: true, completion: nil)
        }
    }
    
    func dismissTrackingOptions() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}