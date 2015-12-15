import UIKit

class TRMonthPresenter: TRCalendarViewDelegate {
    
    var monthView: TRMonthView
//    private var monthModel: TRMonthModel!
    
    init(startColor: UIColor, endColor: UIColor) {
        monthView = TRMonthView(startColor: startColor, endColor: endColor)
        monthView.delegate = self
    }
    
    //MARK: TRCalendarViewDelegate
    
    var recordedDays: TRRecordedDays {
        return TRRecordedDays([1,2], DailyGoalType.Max)
    }
    
}