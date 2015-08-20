import Foundation
/**
The `TRTrackerPresenter` class is designed to act as the mediator between the TRTrackerView and TRTrackerModel.
*/
class TRTrackerPresenter: NSObject, TRTrackerViewDelegate {
    let trackerView : TRTrackerView
    let trackerModel : TRTrackerModel
    var datetoTrack = NSDate()

    var selectedItemOfFirstColumn = 0 {
        didSet {
            self.trackerView.itemPickerView.selectRow(selectedItemOfFirstColumn, inComponent: 0, animated: false)
        }
    }
    
    var selectedItemOfSecondColumn = 0 {
        didSet {
            self.trackerView.itemPickerView.selectRow(selectedItemOfSecondColumn, inComponent: 1, animated: false)
        }
    }
    
    var trackingType : TRTrackingType = .TrackAction {
        didSet {
            self.trackerView.itemPickerView.reloadAllComponents()
            selectedItemOfFirstColumn = 0
            if trackingType == .TrackAction {
                selectedItemOfSecondColumn = 0
            }
            self.trackerView.hiddenPickerViewTextField.becomeFirstResponder()
        }
    }
    
    init(view: TRTrackerView, model: TRTrackerModel) {
        trackerView = view
        trackerModel = model
        super.init()
        self.trackerView.delegate = self
        self.trackerView.itemPickerView.dataSource = self
        self.trackerView.itemPickerView.delegate = self
    }
    
    // MARK: TRTrackerViewDelegate
    func userWantsToTrackAction(){
        trackingType = .TrackAction
    }
    
    func userWantsToTrackUrge(){
        trackingType = .TrackUrge
    }
    
    func userPickedAnItemToTrack() {
        self.trackerModel.trackItemAtRow(selectedItemOfFirstColumn, quantityRow: selectedItemOfSecondColumn, type: trackingType, date: self.datetoTrack)
    }
}
