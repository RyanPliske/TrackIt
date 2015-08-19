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
    var todaysDateButton: UIButton
    var hiddenPickerViewTextField: UITextField
    var itemPickerView = UIPickerView()
    
    let toolBarForTracking = UIToolbar(frame: CGRectMake(0, 0, 320, 44))
    var trackButton = TRTrackerButton(frame: CGRectMake(30, 150, 260, 50), buttonStyle: HTPressableButtonStyle.Rounded, trackingType: .TrackAction)
    var trackUrgeButton = TRTrackerButton(frame: CGRectMake(30, 150, 260, 50), buttonStyle: HTPressableButtonStyle.Rounded, trackingType: .TrackUrge)
    
    var delegate: TRTrackerViewDelegate?
    var observer: TRTrackerViewObserver?
    
    
    required init?(coder aDecoder: NSCoder) {
        
        todaysDateButton = UIButton(frame: CGRectMake(0, 50, 300, 50))
        hiddenPickerViewTextField = UITextField(frame: CGRectZero)
        super.init(coder: aDecoder)
        setUpTodaysDateButton()
        self.addSubview(self.hiddenPickerViewTextField)
        
        self.itemPickerView.backgroundColor = UIColor.blackColor()
        self.hiddenPickerViewTextField.inputView = self.itemPickerView
        
        setToolBarForTrackingPickerView()
        setupTrackingButtons()
        setHiddenTextFieldConstraints()
    }
    
    func setUpTodaysDateButton() {
        todaysDateButton.addTarget(self, action: "todaysDateButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        todaysDateButton.layer.borderColor = UIColor.whiteColor().CGColor
        todaysDateButton.layer.borderWidth = 1.0
        todaysDateButton.layer.cornerRadius = 8.0
        
        if let todaysDateLabel = todaysDateButton.titleLabel {
            todaysDateLabel.font = UIFont(name: "Helvetica", size: 20)
            todaysDateLabel.textColor = UIColor.whiteColor()
            todaysDateLabel.textAlignment = NSTextAlignment.Center
        }
        let centerTodaysDateButtonToCenterX = NSLayoutConstraint(item: todaysDateButton, attribute: NSLayoutAttribute.CenterX, relatedBy: .Equal, toItem: self, attribute:NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        let todaysDateButtonWidth = NSLayoutConstraint(item: todaysDateButton, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.85, constant: 0.0)
        let todaysDateButtonHeightToSuperView = NSLayoutConstraint(item: todaysDateButton, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 30)
        todaysDateButton.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([centerTodaysDateButtonToCenterX, todaysDateButtonWidth, todaysDateButtonHeightToSuperView])
        self.addSubview(self.todaysDateButton)
    }
    
    func setToolBarForTrackingPickerView() {
        let doneButton = UIBarButtonItem(title: "Track", style: UIBarButtonItemStyle.Plain, target: self, action: "userPickedAnItemToTrack:")
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "userCanceledPicking:")

        toolBarForTracking.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        toolBarForTracking.barStyle = UIBarStyle.Black
        hiddenPickerViewTextField.inputAccessoryView = toolBarForTracking
    }
    
    func setupTrackingButtons() {
        trackButton.setButtonLayout(trackButton, theSuperView: self)
        trackUrgeButton.setButtonLayout(trackUrgeButton, theSuperView: self)
        trackButton.addTarget(self, action: "trackButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        trackUrgeButton.addTarget(self, action: "trackUrgeButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setHiddenTextFieldConstraints() {
        hiddenPickerViewTextField.translatesAutoresizingMaskIntoConstraints = false
        hiddenPickerViewTextField.valueForKey("textInputTraits")?.setValue(UIColor.clearColor(), forKey: "insertionPointColor")
        self.addConstraint(NSLayoutConstraint(item: hiddenPickerViewTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: trackButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10))
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
        toolBarForTracking.items![2].title = text
    }
    
    func setTodaysDateLabelWithText(text: String) {
        todaysDateButton.setTitle(text, forState: UIControlState.Normal)
    }
}
