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
                return itemsModel.activeItems.count
            case .TrackUrge:
                return itemsModel.activeSinfulItems.count
            }
        }
        else {
            return TRPreloadedItems.ListOfQuantities.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var pickableItems = [TRItem]()
        switch trackingType {
        case .TrackAction:
            pickableItems = itemsModel.activeItems
        case .TrackUrge:
            pickableItems = itemsModel.activeSinfulItems
        }
        
        if component == 0 {
            if row == selectedItemOfFirstColumn {
                return NSAttributedString(string: pickableItems[row].name as String, attributes: [NSForegroundColorAttributeName:UIColor.TRBabyBlue()])
            }
            return NSAttributedString(string: pickableItems[row].name as String, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        }
        else {
            if row == selectedItemOfSecondColumn {
                return NSAttributedString(string: TRPreloadedItems.ListOfQuantities[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.TRBabyBlue()])
            }
            return NSAttributedString(string: TRPreloadedItems.ListOfQuantities[row] as String, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        }
    }
}