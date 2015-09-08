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
                return self.recordsModel.itemsManager.trackableItems.allItems.count
            case .TrackUrge:
                return self.recordsModel.itemsManager.trackableItems.sinfulItems.count
            }
        }
        else {
            return self.recordsModel.itemsManager.trackableItems.ListOfQuantities.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0 {
            if row == selectedItemOfFirstColumn {
                return NSAttributedString(string: self.recordsModel.itemsManager.trackableItems.allItems[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.blueColor()])
            }
            return NSAttributedString(string: self.recordsModel.itemsManager.trackableItems.allItems[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        }
        else {
            if row == selectedItemOfSecondColumn {
                return NSAttributedString(string: self.recordsModel.itemsManager.trackableItems.ListOfQuantities[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.blueColor()])
            }
            return NSAttributedString(string: self.recordsModel.itemsManager.trackableItems.ListOfQuantities[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        }
    }
}