import Foundation

class DateViewController: UIViewController {
    
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
        self.view = CLWeeklyCalendarView(frame: CGRectMake(0, 0, self.view.bounds.size.width, 100))
        self.preferredContentSize = CGSizeMake(self.view.bounds.width, 100)
    }
}