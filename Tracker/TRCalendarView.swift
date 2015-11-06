import UIKit

class TRCalendarView: UIView {
    
    // We want six weeks for this month
    let week1 = [1, 2, 3, 4, 5, 6, 7]
    let week2 = [8, 9, 10, 11, 12, 13, 14]
    let week3 = [15, 16, 17, 18, 19, 20, 21]
    let week4 = [22, 23, 24, 25, 26, 27, 28]
    let week5 = [29, 30]
    let week6 = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let weeksOfTheMonth = [week1, week2, week3, week4, week5, week6]
        drawWeeks(weeksOfTheMonth)
    }
    
    private func drawWeeks(weeksOfTheMonth: [NSArray]) {
        print(weeksOfTheMonth)
    }
    
}