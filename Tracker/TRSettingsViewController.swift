import UIKit

class TRSettingsViewController: UIViewController {
    
    var settingsPresenter: TRSettingsPresenter?
    @IBOutlet weak var settingsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        settingsPresenter = TRSettingsPresenter(settingsView: settingsTableView)
        settingsTableView.dataSource = self.settingsPresenter
        settingsTableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        settingsTableView.deselectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false)
        settingsTableView.deselectRowAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), animated: false)
    }

}
