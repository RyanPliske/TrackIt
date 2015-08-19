import Foundation

protocol TRDateChooserObserver {
    func dateSelectedWithDate(date: NSDate)
}

class DateViewController: UIViewController, CLWeeklyCalendarViewDelegate {
    
    var dateObserver: TRDateChooserObserver?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.greenColor()
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
}