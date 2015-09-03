import UIKit
import QuartzCore

class TRTrackerViewController: UIViewController, TRTrackerViewObserver, TREditTracksObserver {
    
    @IBOutlet private weak var trackerView: TRTrackerView!
    private var trackerPresenter: TRTrackerPresenter!
    private var recordService = TRRecordService()
    private var trackerModel: TRTrackerModel
    private let dateViewController = TRChooseableDateViewController()
    
    required init?(coder aDecoder: NSCoder) {
        trackerModel = TRTrackerModel(recordService: self.recordService)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trackerPresenter = TRTrackerPresenter(view: self.trackerView, model: self.trackerModel)
        setNeedsStatusBarAppearanceUpdate()
        trackerModel.grabInitialData()
        trackerView.observer = self
        dateViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
        dateViewController.dateObserver = self.trackerPresenter
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor.greenColor()
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
    
    func displayEditableTracks() {
        let editTracksViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EditTracksViewController") as! TREditTracksViewController
        editTracksViewController.editTracksObserver = self
        editTracksViewController.trackerModel = trackerModel
        let navController = UINavigationController(rootViewController: editTracksViewController)
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    // MARK: TREditTracksObserver
    func dismissEditTracks() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}