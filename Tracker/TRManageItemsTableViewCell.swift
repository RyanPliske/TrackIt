import Foundation

protocol TRManageItemsTableViewCellDelegate {
    func toggleSwitchChangedValueAtRow(row: Int)
}

class TRManageItemsTableViewCell: TRSettingsTableViewCell {
    
    @IBOutlet weak var toggleSwitch: UISwitch!
    var manageItemsTableViewCellDelegate: TRManageItemsTableViewCellDelegate?
    
    var toggleSwitchTag: Int {
        get { return self.toggleSwitch.tag }
        set { self.toggleSwitch.tag = newValue }
    }

    @IBAction func toggleSwitchPressed(sender: AnyObject) {
        manageItemsTableViewCellDelegate?.toggleSwitchChangedValueAtRow(toggleSwitchTag)
    }
    
}