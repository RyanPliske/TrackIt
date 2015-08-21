import UIKit
import QuartzCore

class TRTrackerViewController: UIViewController, TRTrackerViewObserver, TREditTracksObserver {
    
    @IBOutlet private weak var trackerView: TRTrackerView!
    private var trackerPresenter: TRTrackerPresenter!
    private var recordService = TRRecordService()
    private var trackerModel: TRTrackerModel!
    private let dateViewController = TRChooseableDateViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        trackerModel = TRTrackerModel(recordService: self.recordService)
        trackerPresenter = TRTrackerPresenter(view: self.trackerView, model: self.trackerModel)
        self.trackerView.observer = self
        dateViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
        dateViewController.dateObserver = self.trackerPresenter
    }
    
    override func viewWillAppear(animated: Bool) {
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
        let editTracksViewController = TREditTracksTableViewController(style: UITableViewStyle.Plain)
        editTracksViewController.editTracksObserver = self
        let navController = UINavigationController(rootViewController: editTracksViewController)
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    // MARK: TREditTracksObserver
    func dismissEditTracks() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}