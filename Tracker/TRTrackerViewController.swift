import UIKit
import QuartzCore

class TRTrackerViewController: UIViewController, TRTrackerViewObserver {
    
    @IBOutlet private weak var trackerView: TRTrackerView!
    private var trackerPresenter: TRTrackerPresenter!
    private var recordService = TRRecordService()
    private var recordsModel: TRRecordsModel!
    private let dateViewController = TRChooseableDateViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordsModel = TRRecordsModel.sharedInstanceOfRecordsModel
        trackerPresenter = TRTrackerPresenter(view: self.trackerView, model: self.recordsModel!)
        setNeedsStatusBarAppearanceUpdate()
        trackerView.observer = self
        dateViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
        dateViewController.dateObserver = self.trackerPresenter
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir", size: 25.0)!]
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