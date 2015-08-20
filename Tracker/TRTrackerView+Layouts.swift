import Foundation

extension TRTrackerView {
    func addConstraintsForTodaysDateButton() {
        todaysDateButton.translatesAutoresizingMaskIntoConstraints = false
        let centerTodaysDateButtonToCenterX = NSLayoutConstraint(item: todaysDateButton, attribute: NSLayoutAttribute.CenterX, relatedBy: .Equal, toItem: self, attribute:NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        let todaysDateButtonWidth = NSLayoutConstraint(item: todaysDateButton, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.85, constant: 0.0)
        let todaysDateButtonHeightWithinSuperView = NSLayoutConstraint(item: todaysDateButton, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: -70)
        addConstraints([centerTodaysDateButtonToCenterX, todaysDateButtonWidth, todaysDateButtonHeightWithinSuperView])
    }
    
    func addConstraintsForHiddenTextField() {
        hiddenPickerViewTextField.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: hiddenPickerViewTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: trackButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10))
    }
    
    func addConstraintsForEditRecordsButton() {
        editRecordsButton.translatesAutoresizingMaskIntoConstraints = false
        let pintEditButtonToTopOfView = NSLayoutConstraint(item: editRecordsButton, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 30.0)
        let editButtonsRightAlignment = NSLayoutConstraint(item: editRecordsButton, attribute: .Right, relatedBy: .Equal, toItem: todaysDateButton, attribute: .Right, multiplier: 1.0, constant: 0.0)
        addConstraints([pintEditButtonToTopOfView, editButtonsRightAlignment])
    }
}