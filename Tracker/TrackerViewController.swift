//
//  TrackerViewController.swift
//  Tracker
//
//  Created by Ryan Pliske on 2/7/15.
//  Copyright (c) 2015 Tracker. All rights reserved.
//

import UIKit
import QuartzCore

class TrackerViewController: UIViewController {
    
    @IBOutlet weak var trackerView: UIView!
    @IBOutlet weak var dateTextField: UITextField!

    
    var trackableItems : TrackableItems!
    let itemPickerView = UIPickerView()
    let datePickerView = UIPickerView()
    let datePicker = DatePicker()
    let toolBar = toolBarForPickerView(frame: CGRectMake(0, 0, 320, 44))
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
    // Just setting this to an intial value to avoid Optionals
    // When user selects to either "Track" or "Track Urge", I'm using the same UIPickerView to display a different list accordingly.
    // This didSet gets called whenever trackingType changes (aka User clicked on a button)
    // and thus will Reset Clicker Wheel Elements
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
        self.setNeedsStatusBarAppearanceUpdate()
        trackerView.addSubview(hiddenPickerViewTextField)
        itemPickerView.dataSource = self; itemPickerView.delegate = self
        itemPickerView.backgroundColor = UIColor.blackColor()
        itemPickerView.showsSelectionIndicator = true
        self.hiddenPickerViewTextField.inputView = itemPickerView
        
        datePickerView.dataSource = datePicker; datePickerView.delegate = datePicker
        dateTextField.inputView = datePickerView
        
        
        setToolBarForTrackingPickerView()
        // setToolBarForDatePickerView()
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
        trackerView.addConstraint(NSLayoutConstraint(item: hiddenPickerViewTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: trackButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10))
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
        
        toolBar.barStyle = UIBarStyle.Black
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "userPicked:")
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        // let toolBarTitle = UILabel(frame: CGRectMake(0, 0, toolBar.bounds.size.width, toolBar.bounds.size.height))
        toolBar.toolBarTitle!.text = "Track"
        toolBar.toolBarTitle!.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        toolBar.toolBarTitle!.textAlignment = NSTextAlignment.Center
        toolBar.toolBarTitle!.textColor = UIColor.grayColor()
        flexibleSpace.customView = toolBar.toolBarTitle
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "userCanceledPicking:")
        
        toolBar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        
        hiddenPickerViewTextField.inputAccessoryView = toolBar
    }
    
//    func setToolBarForDatePickerView(){
//        let toolBar = UIToolbar(frame: CGRectMake(0, 0, 320, 44))
//        let dateLabelForPickerView = UILabel(frame: CGRectMake(0, 0, toolBar.bounds.size.width/3, toolBar.bounds.size.height))
//        dateLabelForPickerView.text = "Choose Date:"
//        let toolBarTitle = UIBarButtonItem(customView: dateLabelForPickerView)
//        let emptySpaceLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
//        let emptySpaceRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
//        toolBar.setItems([emptySpaceLeft, toolBarTitle, emptySpaceRight], animated: false)
//        dateTextField.inputAccessoryView = toolBar
//    }
    
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
        toolBar.toolBarTitle!.text = "Track"
    }
    
    func userWantsToTrackUrge(){
        trackingType = .TrackUrge
        toolBar.toolBarTitle!.text = "Track Urge"
    }
    
    @IBAction func userClickedDateTextField(sender: AnyObject) {
        
    }
}