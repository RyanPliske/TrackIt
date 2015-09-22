import UIKit
import QuartzCore

class TRTrackerViewController: UIViewController, TRTrackerViewObserver {
    
    @IBOutlet private weak var trackerView: TRTrackerView!
    private var trackerPresenter: TRTrackerPresenter!
    private var recordService = TRRecordService()
    private var recordsModel: TRRecordsModel!
    private let dateViewController = TRChooseableDateViewController()
    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        recordsModel = TRRecordsModel.sharedInstanceOfRecordsModel
        trackerPresenter = TRTrackerPresenter(view: self.trackerView, model: self.recordsModel!)
        activityMonitor.startAnimating()
        weak var weakSelf = self
        recordsModel.readAllRecords { () -> Void in
            weakSelf?.trackerView.trackerTableView.reloadData()
            weakSelf?.activityMonitor.stopAnimating()
            weakSelf?.activityMonitor.hidden = true
        }
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        trackerView.observer = self
        dateViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
        dateViewController.dateObserver = self.trackerPresenter
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir", size: 25.0)!]
    }
    
    override func viewWillAppear(animated: Bool) {
        trackerView.trackerTableView.reloadData()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    // MARK: TRTrackerViewObserver
    func displayDateChooser() {
        if let popOver : UIPopoverPresentationController = dateViewController.popoverPresentationController {
            popOver.permittedArrowDirections = UIPopoverArrowDirection.Up
            popOver.delegate = dateViewController
            popOver.sourceView = self.trackerView
            popOver.sourceRect = self.trackerView.todaysDateButton.frame
            self.presentViewController(dateViewController, animated: true, completion: nil)
        }
    }
}