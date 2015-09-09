import Foundation
/**
The `TRTrackerPresenter` class is designed to act as the mediator between the TRTrackerView and TRRecordsModel.
*/
class TRTrackerPresenter: NSObject, TRTrackerViewDelegate {
    let trackerView: TRTrackerView
    let recordsModel: TRRecordsModel
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
    
    var trackingType : TRRecordType = .TrackAction {
        didSet {
            self.trackerView.itemPickerView.reloadAllComponents()
            selectedItemOfFirstColumn = 0
            if trackingType == .TrackAction {
                selectedItemOfSecondColumn = 0
            }
            self.trackerView.hiddenPickerViewTextField.becomeFirstResponder()
        }
    }
    
    init(view: TRTrackerView, model: TRRecordsModel) {
        trackerView = view
        recordsModel = model
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
        self.recordsModel.createRecordUsingRow(selectedItemOfFirstColumn, quantityRow: selectedItemOfSecondColumn, type: trackingType, date: self.datetoTrack)
    }
}
