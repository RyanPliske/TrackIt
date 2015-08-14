extension TRTrackerPresenter: UIPickerViewDelegate {
    
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