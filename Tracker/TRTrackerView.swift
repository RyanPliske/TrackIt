import UIKit

protocol TRTrackerViewDelegate {
    func userWantsToTrackAction()
    func userWantsToTrackUrge()
    func userPickedAnItemToTrack()
}

protocol TRTrackerViewObserver {
    func displayDateChooser()
}

class TRTrackerView: UIView {
    @IBOutlet weak var todaysDateButton: TRTodaysDateButton!
    
    var delegate: TRTrackerViewDelegate?
    var observer: TRTrackerViewObserver?
    
    override func willMoveToWindow(newWindow: UIWindow?) {
        super.willMoveToWindow(newWindow)
        setTodaysDateButtonLabelWithText(TRDateFormatter.descriptionForToday)
    }
    
    // MARK: User Interaction
    func trackButtonTapped() {
        self.delegate?.userWantsToTrackAction()
    }
    
    func trackUrgeButtonTapped() {
        self.delegate?.userWantsToTrackUrge()
    }
    
    @IBAction func todaysDateButtonPressed() {
        self.observer?.displayDateChooser()
    }
    
    // MARK: Setters
    func setTodaysDateButtonLabelWithText(text: String) {
        todaysDateButton.setTitle(text, forState: UIControlState.Normal)
    }
}
