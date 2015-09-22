import Foundation
/**
The `TRTrackerPresenter` class is designed to act as the mediator between the TRTrackerView and TRRecordsModel.
*/
class TRTrackerPresenter: NSObject, TRTrackerViewDelegate {
    let trackerView: TRTrackerView
    let recordsModel: TRRecordsModel
    let itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    var datetoTrack = NSDate()
    var trackingType : TRRecordType = .TrackAction

    
    init(view: TRTrackerView, model: TRRecordsModel) {
        trackerView = view
        recordsModel = model
        super.init()
        self.trackerView.delegate = self
    }
    
    // MARK: TRTrackerViewDelegate
    func userWantsToTrackAction(){
        trackingType = .TrackAction
    }
    
    func userWantsToTrackUrge(){
        trackingType = .TrackUrge
    }
    
    func userPickedAnItemToTrack() {
//        self.recordsModel.createRecordUsingRow(selectedItemOfFirstColumn, quantityRow: selectedItemOfSecondColumn, type: trackingType, date: self.datetoTrack)
    }
}
