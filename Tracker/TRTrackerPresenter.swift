import Foundation

class TRTrackerPresenter: NSObject, TRTrackerViewDelegate, TRDateChooserObserver {
    let trackerView : TRTrackerView
    let trackerModel : TRTrackerModel
    var dateFormatter = TRDateFormatter()
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
        self.trackerView.setTodaysDateLabelWithText(dateFormatter.descriptionForToday)
    }
    // MARK: TRTrackerViewDelegate
    func userWantsToTrackAction(){
        trackingType = .TrackAction
        self.trackerView.setToolBarForTrackingTitle("Track")
    }
    
    func userWantsToTrackUrge(){
        trackingType = .TrackUrge
        self.trackerView.setToolBarForTrackingTitle("Track Urge")
    }
    
    func userPickedAnItemToTrack() {
        self.trackerModel.trackItemAtRow(selectedItemOfFirstColumn, quantityRow: selectedItemOfSecondColumn, type: trackingType, date: self.datetoTrack)
    }
    // MARK: TRDateChooserObserver
    func dateSelectedWithDate(date: NSDate) {
        self.trackerView.setTodaysDateLabelWithText(dateFormatter.descriptionForDate(date))
        self.datetoTrack = date
    }
}
