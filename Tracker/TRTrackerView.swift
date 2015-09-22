import UIKit

protocol TRTrackerViewDelegate {
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
    var pathToReload: NSIndexPath?
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let path = pathToReload where path == indexPath {
            return 400
        }
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath == pathToReload {
            pathToReload = nil
        } else {
            pathToReload = indexPath
        }
        trackerTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        trackerTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        
    }
}
