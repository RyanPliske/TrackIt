import UIKit
import Spring

class TRTrackerTableViewCellWithPlusButton: TRTrackerTableViewCell {
    @IBOutlet private weak var plusButton: SpringButton!
    
    @IBAction func plusButtonPressed(sender: AnyObject) {
        delegate.plusButtonPressedAtRow(self.tag) { [weak self]() -> Void in
           self?.resetCalendarAfterTrackOccured()
        }
        plusButton.animation = "pop"
        plusButton.force = 5.0
        updateItemLabelCountWith(1.0)
        plusButton.animate()
    }
}