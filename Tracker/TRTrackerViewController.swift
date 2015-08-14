import UIKit
import QuartzCore

class TRTrackerViewController: UIViewController {
    
    @IBOutlet weak var trackerView: TRTrackerView!
    var trackerPresenter: TRTrackerPresenter!
    var trackerModel: TRTrackerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        trackerModel = TRTrackerModel()
        trackerPresenter = TRTrackerPresenter(view: self.trackerView, model: self.trackerModel)
        self.trackerView.dateTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.tintColor = UIColor.greenColor()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
}