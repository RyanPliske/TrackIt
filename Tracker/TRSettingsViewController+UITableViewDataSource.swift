import Foundation

extension TRSettingsViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsModel.settings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Note: reuseIdentifier is from Storyboard
        let cell: TRSettingsTableViewCell = tableView.dequeueReusableCellWithIdentifier("settings") as! TRSettingsTableViewCell
        cell.setSettingNameWith(settingsModel.settings[indexPath.row])
        return cell
    }
    
}