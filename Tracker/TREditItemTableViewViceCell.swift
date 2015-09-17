import UIKit

protocol TREditItemTableViewViceCellDelegate {
    func toggleSwitchChangedValueAtRow()
}

class TREditItemTableViewViceCell: TRSettingsTableViewCell {
    
    @IBOutlet private weak var viceSwitch: UISwitch!
    var viceSwitchDelegate: TREditItemTableViewViceCellDelegate?
    var viceSwitchState: Bool {
        return viceSwitch.on
    }
    
    func setViceSwitchTo(status: Bool) {
        viceSwitch.setOn(status, animated: false)
    }
    
    func setViewSwitchUserInteraction(enabled: Bool) {
        viceSwitch.userInteractionEnabled = enabled
    }
    
    @IBAction func viceSwitchPressed(sender: AnyObject) {
        viceSwitchDelegate?.toggleSwitchChangedValueAtRow()
    }
    
}