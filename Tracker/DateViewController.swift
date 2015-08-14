import Foundation

class DateViewController: UIViewController {
    let datePickerView: UIPickerView
    
    init() {
        datePickerView = UIPickerView()
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
    }
}