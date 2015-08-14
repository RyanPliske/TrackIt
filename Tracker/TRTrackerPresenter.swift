import Foundation

class TRTrackerPresenter: NSObject, TRTrackerViewDelegate {
    let trackerView : TRTrackerView
    let trackerModel : TRTrackerModel
    var trackableItems: TRTrackableItems
    
    var chooseableDates = ChooseableDates(month: CurrentDate.months[CurrentDate.thisMonth - 1], day: CurrentDate.days[0])
    
    var selectedItemOfFirstWheelColumn = 0 {
        didSet {
            self.trackerView.itemPickerView.selectRow(selectedItemOfFirstWheelColumn, inComponent: 0, animated: false)
        }
    }
    
    var selectedItemOfSecondWheelColumn = 0 {
        didSet {
            self.trackerView.itemPickerView.selectRow(selectedItemOfSecondWheelColumn, inComponent: 1, animated: false)
        }
    }
    
    var trackingType : TRTrackingType = .TrackAction {
        didSet {
            self.trackerView.itemPickerView.reloadAllComponents()
            selectedItemOfFirstWheelColumn = 0
            if trackingType == .TrackAction {
                selectedItemOfSecondWheelColumn = 0
            }
            self.trackerView.hiddenPickerViewTextField.becomeFirstResponder()
        }
    }
    
    init(view: TRTrackerView, model: TRTrackerModel) {
        trackerView = view
        trackerModel = model
        trackableItems = TRTrackableItems()
        super.init()
        
        self.trackerView.setTodaysDateLabelWith(chooseableDates.description)
        self.trackerView.delegate = self
        
        self.trackerView.itemPickerView.dataSource = self
        self.trackerView.itemPickerView.delegate = self
    }
    
    func userWantsToTrackAction(){
        trackingType = .TrackAction
        self.trackerView.setToolBarForTrackingTitle("Track")
    }
    
    func userWantsToTrackUrge(){
        trackingType = .TrackUrge
        self.trackerView.setToolBarForTrackingTitle("Track Urge")
    }

}
