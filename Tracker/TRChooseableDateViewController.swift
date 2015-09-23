import Foundation

protocol TRDateChooserObserver {
    func dateSelectedWithDate(date: NSDate)
}

class TRChooseableDateViewController: UIViewController, CLWeeklyCalendarViewDelegate, UIPopoverPresentationControllerDelegate {
    
    var dateObserver: TRDateChooserObserver?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
        let calendarView = CLWeeklyCalendarView(frame: CGRectMake(0, 0, self.view.bounds.size.width, 100))
        calendarView.delegate = self
        self.view = calendarView
        self.preferredContentSize = CGSizeMake(self.view.bounds.width, 100)
    }
    
    // MARK: CLWeeklyCalendarViewDelegate
    func dailyCalendarViewDidSelect(date: NSDate!) {
        if let observer = dateObserver {
            observer.dateSelectedWithDate(date)
        }
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}