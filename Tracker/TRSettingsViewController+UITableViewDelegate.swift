import Foundation

extension TRSettingsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 0) {
            self.performSegueWithIdentifier("showManageItems", sender: self)
        } else if (indexPath.row == 1) {
            self.performSegueWithIdentifier("showEditTracks", sender: self)
        }
    }
    
}