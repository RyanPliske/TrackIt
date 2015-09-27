import Foundation
import Spring

class TRTrackerTableViewCellWithPlusButton: TRTrackerTableViewCell {
    @IBOutlet private weak var plusButton: SpringButton!
    
    @IBAction func plusButtonPressed(sender: AnyObject) {
        self.delegate?.plusButtonPressedAtRow(self.tag)
        plusButton.animation = "pop"
        plusButton.force = 5.0
        plusButton.animate()
        if let dateSelected = dateSelectedOnJTCalendar {
            selectedDatesOnJTCalendar.append(TRDateFormatter.descriptionForDate(dateSelected))
        }
        calendarManager.reload()
    }
}