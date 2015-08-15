extension TRTrackerPresenter: UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        switch trackingType {
        case .TrackAction:
            return 2
        case .TrackUrge:
            return 1
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            switch trackingType {
            case .TrackAction:
                return self.trackerModel.trackableItems.getCountOfAllItems()
            case .TrackUrge:
                return self.trackerModel.trackableItems.sinfulItems.count
            }
        }
        else {
            return self.trackerModel.trackableItems.ListOfQuantities.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0 {
            var items = self.trackerModel.trackableItems.sinfulItems + self.trackerModel.trackableItems.regularItems
            if row == selectedItemOfFirstWheelColumn {
                return NSAttributedString(string: items[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.greenColor()])
            }
            return NSAttributedString(string: items[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        }
        else {
            if row == selectedItemOfSecondWheelColumn {
                return NSAttributedString(string: self.trackerModel.trackableItems.ListOfQuantities[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.greenColor()])
            }
            return NSAttributedString(string: self.trackerModel.trackableItems.ListOfQuantities[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        }
    }
}