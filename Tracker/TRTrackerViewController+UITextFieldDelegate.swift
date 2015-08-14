extension TRTrackerViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let dateViewController = DateViewController()
        dateViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
        if let popOver : UIPopoverPresentationController = dateViewController.popoverPresentationController {
            popOver.permittedArrowDirections = UIPopoverArrowDirection.Up
            popOver.delegate = dateViewController
            popOver.sourceView = self.trackerView
            popOver.sourceRect = self.trackerView.dateTextField.frame
            self.presentViewController(dateViewController, animated: true, completion: nil)
        }
    }
    
}