import UIKit

protocol TRManageItemsTableViewCellDelegate {
    func toggleSwitchChangedValueAtRow(row: Int)
}

class TRManageItemsTableViewCell: TRSettingsTableViewCell {
    
    @IBOutlet weak var toggleSwitch: UISwitch!
    var manageItemsTableViewCellDelegate: TRManageItemsTableViewCellDelegate?

    @IBAction func toggleSwitchPressed(sender: AnyObject) {
        manageItemsTableViewCellDelegate?.toggleSwitchChangedValueAtRow(toggleSwitch.tag)
    }
    
}