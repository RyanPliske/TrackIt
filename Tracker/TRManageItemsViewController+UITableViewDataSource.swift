import Foundation

extension TRManageItemsViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: TRSettingsTableViewCell = tableView.dequeueReusableCellWithIdentifier("items") as! TRSettingsTableViewCell
        if (indexPath.row == 0) {
            cell.topBorder.hidden = false
        } else if (indexPath.row == 2) {
            cell.bottomBorder.hidden = false
        }
        cell.setSettingNameWith("\(indexPath.row)")
        return cell
    }
    
}