import UIKit

class TREditItemTableViewViceCell: TRSettingsTableViewCell {
    
    @IBOutlet private weak var viceSwitch: UISwitch!
    
    func setViceSwitchTo(status: Bool) {
        viceSwitch.setOn(status, animated: false)
    }
    
    func setViewSwitchUserInteraction(enabled: Bool) {
        viceSwitch.userInteractionEnabled = enabled
    }
}