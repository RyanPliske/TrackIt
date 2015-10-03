import Foundation
import Spring

class TRTrackerTableViewCellWithPlusButton: TRTrackerTableViewCell {
    @IBOutlet private weak var plusButton: SpringButton!
    
    @IBAction func plusButtonPressed(sender: AnyObject) {
        self.delegate?.plusButtonPressedAtRow(self.tag)
        plusButton.animation = "pop"
        plusButton.force = 5.0
        setItemLabelTextWith(label.name, itemCount: ++label.count)
        plusButton.animate()
        resetCalendarAfterTrackOccured()
    }
}