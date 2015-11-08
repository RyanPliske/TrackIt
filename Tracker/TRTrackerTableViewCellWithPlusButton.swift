import Foundation
import Spring

class TRTrackerTableViewCellWithPlusButton: TRTrackerTableViewCell {
    @IBOutlet private weak var plusButton: SpringButton!
    
    @IBAction func plusButtonPressed(sender: AnyObject) {
        delegate.plusButtonPressedAtRow(self.tag)
        plusButton.animation = "pop"
        plusButton.force = 5.0
        updateItemLabelCountWith(1.0)
        plusButton.animate()
        resetCalendarAfterTrackOccured()
    }
}