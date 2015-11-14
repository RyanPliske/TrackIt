import Foundation

class TRSettingsPresenter: NSObject, UITableViewDataSource {
    
    private let settingsView: UITableView
    
    init(settingsView: UITableView) {
        self.settingsView = settingsView
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TRSettingsModel.settings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Note: reuseIdentifier is from Storyboard
        let cell: TRSettingsTableViewCell = tableView.dequeueReusableCellWithIdentifier("settings") as! TRSettingsTableViewCell
        if (indexPath.row == 0) {
            cell.topBorder.hidden = false
        } else if (indexPath.row == TRSettingsModel.settings.count - 1) {
            cell.bottomBorder.hidden = false
        }
        cell.setSettingNameWith(TRSettingsModel.settings[indexPath.row])
        return cell
    }
    
}