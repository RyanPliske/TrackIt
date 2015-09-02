import UIKit

class TRSettingsViewController: UIViewController {
    
    var settingsModel = TRSettingsModel()
    @IBOutlet weak var settingsTableView: TRSettingsTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        title = "Settings"
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // For now this will work. In the future I'll want to deselect a specific row.
        settingsTableView.deselectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

}
