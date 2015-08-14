import UIKit
import QuartzCore

class TrackerViewController: UIViewController {
    
    @IBOutlet weak var trackerView: UIView!
    @IBOutlet weak var dateTextField: UITextField!
//    var dateTextField: UITextField!
    var trackableItems : TrackableItems!
    var itemPickerView = UIPickerView()
    var datePickerView = UIPickerView()
    let datePicker = DatePicker()
    let toolBarForTracking = ToolBarForPickerView(frame: CGRectMake(0, 0, 320, 44))
    var hiddenPickerViewTextField = UITextField(frame: CGRectZero)
    
    var selectedItemOfFirstWheelColumn = 0 {
        didSet {
            itemPickerView.selectRow(selectedItemOfFirstWheelColumn, inComponent: 0, animated: false)
        }
    }
    var selectedItemOfSecondWheelColumn = 0 {
        didSet {
           itemPickerView.selectRow(selectedItemOfSecondWheelColumn, inComponent: 1, animated: false)
        }
    }
    var trackButton = TrackerButton(frame: CGRectMake(30, 150, 260, 50), buttonStyle: HTPressableButtonStyle.Rounded, trackingType: .TrackAction)
    var trackUrgeButton = TrackerButton(frame: CGRectMake(30, 150, 260, 50), buttonStyle: HTPressableButtonStyle.Rounded, trackingType: .TrackUrge)

    var trackingType : TrackingType = .TrackAction {
        didSet {
            itemPickerView.reloadAllComponents()
            selectedItemOfFirstWheelColumn = 0
            if trackingType == .TrackAction {
                selectedItemOfSecondWheelColumn = 0
            }
            hiddenPickerViewTextField.becomeFirstResponder()
        }
    }
    var chooseableDates = ChooseableDates(month: CurrentDate.months[CurrentDate.thisMonth - 1], day: CurrentDate.days[0])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        
        self.view.addSubview(hiddenPickerViewTextField)
//        dateTextField = UITextField()
//        dateTextField.frame = 
//        self.view.addSubview(self.dateTextField)
        
        itemPickerView.dataSource = self
        itemPickerView.delegate = self
        itemPickerView.backgroundColor = UIColor.orangeColor()
        itemPickerView.showsSelectionIndicator = true
        hiddenPickerViewTextField.inputView = itemPickerView
        datePickerView.dataSource = datePicker
        datePickerView.delegate = datePicker
        datePickerView.backgroundColor = UIColor.blackColor()
        setToolBarForTrackingPickerView()
        setuptheLayout()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        trackableItems = appDelegate.getTheTrackableItems()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.tintColor = UIColor.greenColor()
    }
    
    func setuptheLayout(){
        // Setup for Buttons
        trackButton.setButtonLayout(trackButton, theSuperView: trackerView)
        trackUrgeButton.setButtonLayout(trackUrgeButton, theSuperView: trackerView)
        trackButton.addTarget(self, action: "userWantsToTrackAction", forControlEvents: UIControlEvents.TouchUpInside)
        trackUrgeButton.addTarget(self, action: "userWantsToTrackUrge", forControlEvents: UIControlEvents.TouchUpInside)
        // Create NSLayout for text field so it raises when button is pressed
        hiddenPickerViewTextField.translatesAutoresizingMaskIntoConstraints = false
        hiddenPickerViewTextField.valueForKey("textInputTraits")?.setValue(UIColor.clearColor(), forKey: "insertionPointColor")
//        trackerView.addConstraint(NSLayoutConstraint(item: hiddenPickerViewTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: trackButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10))
        // Setup for Date Text Field
        dateTextField.backgroundColor = UIColor.blackColor()
        dateTextField.layer.borderColor = UIColor.whiteColor().CGColor
        dateTextField.layer.borderWidth = 1.0
        dateTextField.layer.cornerRadius = 8.0
        dateTextField.layer.masksToBounds = true
        dateTextField.text = chooseableDates.description
        dateTextField.valueForKey("textInputTraits")?.setValue(UIColor.clearColor(), forKey: "insertionPointColor")
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    func userCanceledPicking(sender: UIBarButtonItem){
        hiddenPickerViewTextField.resignFirstResponder()
    }
    
    func userPicked(sender: UIBarButtonItem){
        hiddenPickerViewTextField.resignFirstResponder()
    }
    
    func userWantsToTrackAction(){
        trackingType = .TrackAction
        toolBarForTracking.toolBarTitle?.text = "Track"
    }
    
    func userWantsToTrackUrge(){
        trackingType = .TrackUrge
        toolBarForTracking.toolBarTitle?.text = "Track Urge"
    }
    
    @IBAction func userClickedDateTextField(sender: AnyObject) {
        let dateViewController = DateViewController()
        dateViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
        if let popOver : UIPopoverPresentationController = dateViewController.popoverPresentationController {
            popOver.permittedArrowDirections = UIPopoverArrowDirection.Up
            popOver.delegate = dateViewController
            popOver.sourceView = self.view
            popOver.sourceRect = self.dateTextField.frame
            self.presentViewController(dateViewController, animated: true, completion: nil)
        }
    }
}