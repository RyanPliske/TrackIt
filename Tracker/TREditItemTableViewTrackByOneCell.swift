import UIKit

protocol TREditItemTableViewViceCellDelegate {
    func toggleSwitchChangedToValue(value: Bool)
}

class TREditItemTableViewTrackByOneCell: TRSettingsTableViewCell {
    
    @IBOutlet private weak var trackByOneSwitch: UISwitch!

    var trackByOneSwitchDelegate: TREditItemTableViewViceCellDelegate?
    var trackByOneSwitchState: Bool {
        return trackByOneSwitch.on
    }
    
    func setSwitchTo(status: Bool) {
        trackByOneSwitch.setOn(status, animated: false)
    }
    
    @IBAction func switchPressed(sender: AnyObject) {
        trackByOneSwitchDelegate?.toggleSwitchChangedToValue(trackByOneSwitchState)
    }
    
}