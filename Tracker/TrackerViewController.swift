//
//  TrackerViewController.swift
//  Tracker
//
//  Created by Ryan Pliske on 2/7/15.
//  Copyright (c) 2015 Tracker. All rights reserved.
//

import UIKit
import QuartzCore

class TrackerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var trackerView: UIView!
    @IBOutlet weak var dateTextField: UITextField!

    
    var trackableItems : TrackableItems!
    var ItemPickerView = UIPickerView()
    var hiddenPickerViewTextField = UITextField(frame: CGRectZero)
    var selectedItemOfFirstWheelColumn = 0 {
        didSet {
            ItemPickerView.selectRow(selectedItemOfFirstWheelColumn, inComponent: 0, animated: false)
        }
    }
    var selectedItemOfSecondWheelColumn = 0 {
        didSet {
           ItemPickerView.selectRow(selectedItemOfSecondWheelColumn, inComponent: 1, animated: false)
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
            ItemPickerView.reloadAllComponents()
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
        ItemPickerView.dataSource = self; ItemPickerView.delegate = self
        ItemPickerView.backgroundColor = UIColor.blackColor()
        ItemPickerView.showsSelectionIndicator = true
        self.hiddenPickerViewTextField.inputView = ItemPickerView
        setToolBarForPickerView()
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
    }
    
    func setToolBarForPickerView(){
        let toolBar = UIToolbar(frame: CGRectMake(0, 0, 320, 44))
        toolBar.barStyle = UIBarStyle.Black
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "userPicked:")
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "userCanceledPicking:")
        // toolBar.setItems(NSArray(objects: cancelButton, UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil), doneButton ) as [UIBarButtonItem]?, animated: false)
        
        toolBar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        
        hiddenPickerViewTextField.inputAccessoryView = toolBar
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        switch trackingType {
            case .TrackAction:
                return 2
            case .TrackUrge:
                return 1
            case .TrackOnThisDay:
                return 1
        }
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            switch trackingType {
                case .TrackAction:
                    return trackableItems.getCountOfAllItems()
                case .TrackUrge:
                    return trackableItems.sinfulItems.count
                case .TrackOnThisDay:
                    return CurrentDate.days.count
            }
        }
        else {
            return trackableItems.ListOfQuantities.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0 {
            var items = trackableItems.sinfulItems + trackableItems.regularItems
            if row == selectedItemOfFirstWheelColumn {
              return NSAttributedString(string: items[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.greenColor()])
            }
            return NSAttributedString(string: items[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        }
        else {
            if row == selectedItemOfSecondWheelColumn {
                return NSAttributedString(string: trackableItems.ListOfQuantities[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.greenColor()])
            }
            return NSAttributedString(string: trackableItems.ListOfQuantities[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedItemOfFirstWheelColumn = row
        }
        else if component == 1 {
           selectedItemOfSecondWheelColumn = row
        }

        pickerView.reloadComponent(component)
    }
    
    func userCanceledPicking(sender: UIBarButtonItem){
        hiddenPickerViewTextField.resignFirstResponder()
    }
    
    func userPicked(sender: UIBarButtonItem){
        hiddenPickerViewTextField.resignFirstResponder()
    }
    
    func userWantsToTrackAction(){
        trackingType = .TrackAction
    }
    
    func userWantsToTrackUrge(){
        trackingType = .TrackUrge
    }
    
    @IBAction func userClickedDateTextField(sender: AnyObject) {
            trackingType = .TrackOnThisDay
    }
    
    
}

