extension TRTrackerPresenter: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedItemOfFirstColumn = row
        }
        else if component == 1 {
            selectedItemOfSecondColumn = row
        }
        
        pickerView.reloadComponent(component)
    }
}