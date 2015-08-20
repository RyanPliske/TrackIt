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
    let todaysDateButton = TRTodaysDateButton(frame: CGRectMake(0, 50, 300, 50))
    let hiddenPickerViewTextField = UITextField(frame: CGRectZero)
    let itemPickerView = UIPickerView()
    var toolBarForTracking: TRToolbar?
    let editRecordsButton = TREditRecordsButton(frame: CGRectMake(0.0, 0.0, 100.0, 30.0))
    var trackButton = TRTrackerButton(frame: CGRectMake(30.0, 150.0, 260.0, 50.0), buttonStyle: HTPressableButtonStyle.Rounded, trackingType: .TrackAction)
    var trackUrgeButton = TRTrackerButton(frame: CGRectMake(30.0, 150.0, 260.0, 50.0), buttonStyle: HTPressableButtonStyle.Rounded, trackingType: .TrackUrge)
    
    var delegate: TRTrackerViewDelegate?
    var observer: TRTrackerViewObserver?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        todaysDateButton.addTarget(self, action: "todaysDateButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        addConstraintsForTodaysDateButton()
        addSubview(todaysDateButton)
        
        itemPickerView.backgroundColor = UIColor.blackColor()
        hiddenPickerViewTextField.inputView = itemPickerView
        toolBarForTracking = TRToolbar(frame: CGRectMake(0.0, 0.0, 320.0, 44.0), parentView: self)
        hiddenPickerViewTextField.inputAccessoryView = toolBarForTracking
        hiddenPickerViewTextField.valueForKey("textInputTraits")?.setValue(UIColor.clearColor(), forKey: "insertionPointColor")
        addConstraintsForHiddenTextField()
        addSubview(hiddenPickerViewTextField)
        
        addConstraintsForEditRecordsButton()
        addSubview(editRecordsButton)
        
        setupTrackingButtons()
    }
    
    func setupTrackingButtons() {
        trackButton.addTarget(self, action: "trackButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        trackButton.setButtonLayout(trackButton, theSuperView: self)
        
        trackUrgeButton.addTarget(self, action: "trackUrgeButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        trackUrgeButton.setButtonLayout(trackUrgeButton, theSuperView: self)
    }
    
    func userCanceledPicking(sender: UIBarButtonItem) {
        hiddenPickerViewTextField.resignFirstResponder()
    }
    
    func userPickedAnItemToTrack(sender: UIBarButtonItem) {
        hiddenPickerViewTextField.resignFirstResponder()
        self.delegate?.userPickedAnItemToTrack()
    }
    
    func trackButtonTapped() {
        self.delegate?.userWantsToTrackAction()
    }
    
    func trackUrgeButtonTapped() {
        self.delegate?.userWantsToTrackUrge()
    }
    
    func todaysDateButtonPressed() {
        self.observer?.displayDateChooser()
    }
    
    func setToolBarForTrackingTitle(text: String) {
        toolBarForTracking?.items![2].title = text
    }
    
    func setTodaysDateLabelWithText(text: String) {
        todaysDateButton.setTitle(text, forState: UIControlState.Normal)
    }
}
