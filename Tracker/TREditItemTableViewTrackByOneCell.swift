import UIKit

protocol TREditItemTableViewViceCellDelegate {
    func toggleSwitchChangedToValue(value: Bool)
}

class TREditItemTableViewTrackByOneCell: TRSettingsTableViewCell {
    
    @IBOutlet private weak var trackByOneSwitch: UISwitch!
    @IBOutlet private weak var trackByOneLabel: UILabel!
    var trackByOneSwitchDelegate: TREditItemTableViewViceCellDelegate?
    var trackByOneSwitchState: Bool {
        return trackByOneSwitch.on
    }
    
    func setSwitchTo(status: Bool) {
        trackByOneSwitch.setOn(status, animated: false)
    }
    
    func setUserInteraction(enabled:Bool) {
        trackByOneSwitch.userInteractionEnabled = enabled
        trackByOneSwitch.alpha = enabled ? 1.0 : 0.5
        trackByOneLabel.alpha = enabled ? 1.0 : 0.5
    }
    
    @IBAction func switchPressed(sender: AnyObject) {
        trackByOneSwitchDelegate?.toggleSwitchChangedToValue(trackByOneSwitchState)
    }
    
}