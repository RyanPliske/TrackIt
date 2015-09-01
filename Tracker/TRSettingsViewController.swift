import UIKit

class TRSettingsViewController: UIViewController, UITableViewDataSource {
    
    private var settingsModel = TRSettingsModel()
    @IBOutlet weak var settingsTableView: TRSettingsTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsModel.settings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Note: reuseIdentifier is from Storyboard
        let cell: TRSettingsTableViewCell = tableView.dequeueReusableCellWithIdentifier("settings") as! TRSettingsTableViewCell
        return cell
    }
}
