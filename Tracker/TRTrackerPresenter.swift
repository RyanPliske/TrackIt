import Foundation

class TRTrackerPresenter: NSObject {
    let trackerView : TRTrackerView
    let trackerModel : TRTrackerModel
    var chooseableDates = ChooseableDates(month: CurrentDate.months[CurrentDate.thisMonth - 1], day: CurrentDate.days[0])
    
    init(view: TRTrackerView, model: TRTrackerModel) {
        trackerView = view
        trackerModel = model
        super.init()
        
        self.trackerView.setDateTextFieldTextWith(chooseableDates.description)
    }
}
