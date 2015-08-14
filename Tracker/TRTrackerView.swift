import UIKit

protocol TRTrackerViewObserver {
    func userWantsToTrackAction()
    func userWantsToTrackUrge()
}

class TRTrackerView: UIView {
    var dateTextField: UITextField
    var hiddenPickerViewTextField: UITextField
    var itemPickerView = UIPickerView()
    
    let toolBarForTracking = ToolBarForPickerView(frame: CGRectMake(0, 0, 320, 44))
    var trackButton = TrackerButton(frame: CGRectMake(30, 150, 260, 50), buttonStyle: HTPressableButtonStyle.Rounded, trackingType: .TrackAction)
    var trackUrgeButton = TrackerButton(frame: CGRectMake(30, 150, 260, 50), buttonStyle: HTPressableButtonStyle.Rounded, trackingType: .TrackUrge)
    
    var trackerViewObserver : TRTrackerViewObserver?
    
    
    required init?(coder aDecoder: NSCoder) {
        
        dateTextField = UITextField(frame: CGRectMake(0, 50, 300, 50))
        hiddenPickerViewTextField = UITextField(frame: CGRectZero)
    
        super.init(coder: aDecoder)
        dateTextField.backgroundColor = UIColor.blackColor()
        dateTextField.textColor = UIColor.whiteColor()
        dateTextField.textAlignment = NSTextAlignment.Center
        dateTextField.layer.borderColor = UIColor.whiteColor().CGColor
        dateTextField.layer.borderWidth = 1.0
        dateTextField.layer.cornerRadius = 8.0
        dateTextField.layer.masksToBounds = true
        dateTextField.valueForKey("textInputTraits")?.setValue(UIColor.clearColor(), forKey: "insertionPointColor")
        self.addSubview(self.dateTextField)
        self.addSubview(self.hiddenPickerViewTextField)
        
        self.itemPickerView.backgroundColor = UIColor.blackColor()
        self.hiddenPickerViewTextField.inputView = self.itemPickerView
        
        setToolBarForTrackingPickerView()
        setuptheLayout()
    }
    
    func setDateTextFieldTextWith(text: String) {
        dateTextField.text = text
    }
    
    func setToolBarForTrackingPickerView(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "userPicked:")
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "userCanceledPicking:")
        flexibleSpace.customView = toolBarForTracking.toolBarTitle
        toolBarForTracking.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        toolBarForTracking.setTitleAttributes()
        hiddenPickerViewTextField.inputAccessoryView = toolBarForTracking
    }
    
    func setuptheLayout(){
        // Setup for Buttons
        trackButton.setButtonLayout(trackButton, theSuperView: self)
        trackUrgeButton.setButtonLayout(trackUrgeButton, theSuperView: self)
        trackButton.addTarget(self, action: "trackButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        trackUrgeButton.addTarget(self, action: "trackUrgeButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        // Create NSLayout for text field so it raises when button is pressed
        hiddenPickerViewTextField.translatesAutoresizingMaskIntoConstraints = false
        hiddenPickerViewTextField.valueForKey("textInputTraits")?.setValue(UIColor.clearColor(), forKey: "insertionPointColor")
        //        trackerView.addConstraint(NSLayoutConstraint(item: hiddenPickerViewTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: trackButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10))
    }
    
    func userCanceledPicking(sender: UIBarButtonItem){
        hiddenPickerViewTextField.resignFirstResponder()
    }
    
    func userPicked(sender: UIBarButtonItem){
        hiddenPickerViewTextField.resignFirstResponder()
    }
    
    func trackButtonTapped(){
        self.trackerViewObserver?.userWantsToTrackAction()
    }
    
    func trackUrgeButtonTapped(){
        self.trackerViewObserver?.userWantsToTrackUrge()
    }
    
    func setToolBarForTrackingTitle(text: String) {
       self.toolBarForTracking.toolBarTitle?.text = text
    }
}
