import UIKit
import HTPressableButton

protocol TRTrackerViewDelegate {
    func userWantsToTrackAction()
    func userWantsToTrackUrge()
    func userPickedAnItemToTrack()
}

protocol TRTrackerViewObserver {
    func displayDateChooser()
}

class TRTrackerView: UIView, TRKeyboardToolbarDelegate {
    let todaysDateButton = TRTodaysDateButton(frame: CGRectMake(0, 50, 300, 50))
    let hiddenPickerViewTextField = TRHiddenTextField(frame: CGRectZero)
    let itemPickerView = UIPickerView()
    var trackButton = TRTrackerButton(frame: CGRectMake(30.0, 150.0, 260.0, 50.0), buttonStyle: HTPressableButtonStyle.Rounded, trackingType: .TrackAction)
    var trackUrgeButton = TRTrackerButton(frame: CGRectMake(30.0, 150.0, 260.0, 50.0), buttonStyle: HTPressableButtonStyle.Rounded, trackingType: .TrackUrge)
    
    var delegate: TRTrackerViewDelegate?
    var observer: TRTrackerViewObserver?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // todaysDateButton
        todaysDateButton.addTarget(self, action: "todaysDateButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        setTodaysDateButtonLabelWithText(TRDateFormatter.descriptionForToday)
        addSubview(todaysDateButton)
        addConstraintsForTodaysDateButton()
        // trackButton
        trackButton.addTarget(self, action: "trackButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(trackButton)
        addConstraintsForTrackerButton(trackButton)
        // trackUrgeButton
        trackUrgeButton.addTarget(self, action: "trackUrgeButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(trackUrgeButton)
        addConstraintsForTrackerButton(trackUrgeButton)
        // hiddenPickerViewTextField
        itemPickerView.backgroundColor = UIColor.blackColor()
        hiddenPickerViewTextField.inputView = itemPickerView
        let doneToolbarView = TRKeyboardToolbar()
        doneToolbarView.toolbarDelegate = self
        hiddenPickerViewTextField.inputAccessoryView = doneToolbarView
        addSubview(hiddenPickerViewTextField)
        addConstraintsForHiddenTextField()
    }
    
    // MARK: User Interaction
    func TRKeyboardToolbarCanceled() {
        hiddenPickerViewTextField.resignFirstResponder()
    }
    
    func TRKeyboardToolbarDone() {
        hiddenPickerViewTextField.resignFirstResponder()
        self.delegate?.userPickedAnItemToTrack()
    }
    
    func trackButtonTapped() {
        self.delegate?.userWantsToTrackAction()
        setToolBarForTrackingTitle("Track")
    }
    
    func trackUrgeButtonTapped() {
        self.delegate?.userWantsToTrackUrge()
        setToolBarForTrackingTitle("Track Urge")
    }
    
    func todaysDateButtonPressed() {
        self.observer?.displayDateChooser()
    }
    
    // MARK: Setters
    func setToolBarForTrackingTitle(text: String) {
        let toolBar = hiddenPickerViewTextField.inputAccessoryView as! TRKeyboardToolbar
        toolBar.items![2].title = text
    }
    
    func setTodaysDateButtonLabelWithText(text: String) {
        todaysDateButton.setTitle(text, forState: UIControlState.Normal)
    }
}
