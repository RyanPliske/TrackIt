import UIKit
import QuartzCore

class TRTrackerViewController: UIViewController, TRTrackerViewObserver {
    
    @IBOutlet private weak var trackerView: TRTrackerView!
    private var trackerPresenter: TRTrackerPresenter!
    private var trackerModel: TRTrackerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        trackerModel = TRTrackerModel()
        trackerPresenter = TRTrackerPresenter(view: self.trackerView, model: self.trackerModel)
        self.trackerView.observer = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.tintColor = UIColor.greenColor()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    func userWantsToSelectDate() {
        let dateViewController = DateViewController()
        dateViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
        if let popOver : UIPopoverPresentationController = dateViewController.popoverPresentationController {
            popOver.permittedArrowDirections = UIPopoverArrowDirection.Up
            popOver.delegate = dateViewController
            popOver.sourceView = self.trackerView
            popOver.sourceRect = self.trackerView.todaysDateButton.frame
            self.presentViewController(dateViewController, animated: true, completion: nil)
        }
    }
    
}