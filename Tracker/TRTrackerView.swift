import UIKit

protocol TRTrackerViewDelegate {
//    func userWantsToTrackAction()
//    func userWantsToTrackUrge()
//    func userPickedAnItemToTrack()
}

protocol TRTrackerViewObserver {
    func displayDateChooser()
}

class TRTrackerView: UIView, UITableViewDelegate {
    @IBOutlet weak var todaysDateButton: UIButton!
    @IBOutlet weak var trackerTableView: UITableView! {
        didSet {
            self.trackerTableView.delegate = self
        }
    }
    
    var delegate: TRTrackerViewDelegate?
    var observer: TRTrackerViewObserver?
    
    override func willMoveToWindow(newWindow: UIWindow?) {
        super.willMoveToWindow(newWindow)
        setTodaysDateButtonLabelWithText(TRDateFormatter.descriptionForToday)
        trackerTableView.showsVerticalScrollIndicator = false
    }
    
    @IBAction func todaysDateButtonPressed() {
        self.observer?.displayDateChooser()
    }
    
    // MARK: Setters
    func setTodaysDateButtonLabelWithText(text: String) {
        todaysDateButton.setTitle(text, forState: UIControlState.Normal)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.sizeToFit()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
}
