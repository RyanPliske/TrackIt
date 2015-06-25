//
//  TrackerViewController+UIPickerViewDelegate.swift
//  Tracker
//
//  Created by Ryan Pliske on 6/24/15.
//  Copyright © 2015 Tracker. All rights reserved.
//

extension TrackerViewController: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedItemOfFirstWheelColumn = row
        }
        else if component == 1 {
            selectedItemOfSecondWheelColumn = row
        }
        
        pickerView.reloadComponent(component)
    }
}