import Foundation

extension TRSettingsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 0) {
            self.performSegueWithIdentifier("showManageItems", sender: self)
        }
    }
    
}