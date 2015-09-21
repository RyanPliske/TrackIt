import Foundation

class TRSettingsPresenter: NSObject, UITableViewDataSource {
    
    private let settingsModel: TRSettingsModel
    private let settingsView: UITableView
    
    init(settingsModel: TRSettingsModel, settingsView: UITableView) {
        self.settingsModel = settingsModel
        self.settingsView = settingsView
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsModel.settings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Note: reuseIdentifier is from Storyboard
        let cell: TRSettingsTableViewCell = tableView.dequeueReusableCellWithIdentifier("settings") as! TRSettingsTableViewCell
        if (indexPath.row == 0) {
            cell.topBorder.hidden = false
        } else if (indexPath.row == settingsModel.settings.count - 1) {
            cell.bottomBorder.hidden = false
        }
        cell.setSettingNameWith(settingsModel.settings[indexPath.row])
        return cell
    }
    
}