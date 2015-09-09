import Foundation

class TRManageItemsTableViewCell: TRSettingsTableViewCell {
    
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    var toggleSwitchTag: Int {
        get { return self.toggleSwitch.tag }
        set { self.toggleSwitch.tag = newValue }
    }

    @IBAction func toggleSwitchPressed(sender: AnyObject) {
        if self.toggleSwitch.on {
            print(self.toggleSwitch.on.description)
            print(toggleSwitchTag)
        } else {
            print(self.toggleSwitch.on.description)
            print(toggleSwitchTag)
        }
    }
    
}