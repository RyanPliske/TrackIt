//
//  DatePicker+UIPickerViewDelegate.swift
//  Tracker
//
//  Created by Ryan Pliske on 7/4/15.
//  Copyright © 2015 Tracker. All rights reserved.
//

import Foundation
import UIKit

class DatePicker : NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(component)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "July 4, 2015"
    }
}