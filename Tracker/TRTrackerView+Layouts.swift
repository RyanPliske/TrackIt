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
        let imageHeight: CGFloat = 20.0
        addConstraintsForEditRecordsButtonImage(imageHeight)
        let pinEditButtonToTopOfView = NSLayoutConstraint(item: editRecordsButton, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 30.0)
        let editButtonRightAlignment = NSLayoutConstraint(item: editRecordsButton, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: -20.0)
        let editButtonHeight = NSLayoutConstraint(item: editRecordsButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: imageHeight)
        let editButtonWidth = NSLayoutConstraint(item: editRecordsButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 100.0)
        addConstraints([pinEditButtonToTopOfView, editButtonRightAlignment, editButtonHeight, editButtonWidth])
    }
    
    func addConstraintsForEditRecordsButtonImage(imageHeight: CGFloat) {
        editRecordsButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        let pinImageToTopOfEditButton = NSLayoutConstraint(item: editRecordsButton.imageView!, attribute: .Top, relatedBy: .Equal, toItem: editRecordsButton, attribute: .Top, multiplier: 1.0, constant: 5.0)
        let pinImageToLeftOfEditButton = NSLayoutConstraint(item: editRecordsButton.imageView!, attribute: .Leading, relatedBy: .Equal, toItem: editRecordsButton, attribute: .Leading, multiplier: 1.0, constant: 6.0)
        let editButtonImageHeight = NSLayoutConstraint(item: editRecordsButton.imageView!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: imageHeight - 10.0)
        let editButtonImageWidthHeightRatio = NSLayoutConstraint(item: editRecordsButton.imageView!, attribute: .Width, relatedBy: .Equal, toItem: editRecordsButton.imageView!, attribute: .Height, multiplier: 1.0, constant: 0.0)
        addConstraints([pinImageToTopOfEditButton, pinImageToLeftOfEditButton, editButtonImageHeight, editButtonImageWidthHeightRatio])
    }
    
    func addConstraintsForTrackerButton(button: TRTrackerButton) {
        button.translatesAutoresizingMaskIntoConstraints = false

        let widthForButton = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0.44, constant: 0)
        let heightForButton = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0.1, constant: 0)
        let yCoordForButton = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 80)
        var xCoordForButton : NSLayoutConstraint!
        
        switch button.trackingType {
            case .TrackAction:
                xCoordForButton = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: 0)
                
            case .TrackUrge:
                xCoordForButton = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1.0, constant: 0)
        }
        addConstraints([widthForButton, heightForButton, yCoordForButton, xCoordForButton])
    }
}