import UIKit

protocol TREditItemTableViewViceCellDelegate {
    func toggleSwitchChangedValueAtRow()
}

class TREditItemTableViewViceCell: TRSettingsTableViewCell {
    
    @IBOutlet private weak var viceSwitch: UISwitch!
    @IBOutlet private weak var viceLabel: UILabel!
    var viceSwitchDelegate: TREditItemTableViewViceCellDelegate?
    var viceSwitchState: Bool {
        return viceSwitch.on
    }
    
    func setViceSwitchTo(status: Bool) {
        viceSwitch.setOn(status, animated: false)
    }
    
    func setViewSwitchUserInteraction(enabled: Bool) {
        viceSwitch.userInteractionEnabled = enabled
        viceSwitch.alpha = enabled ? 1.0 : 0.5
        viceLabel.alpha = enabled ? 1.0 : 0.5
    }
    
    @IBAction func viceSwitchPressed(sender: AnyObject) {
        viceSwitchDelegate?.toggleSwitchChangedValueAtRow()
    }
    
}