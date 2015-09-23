import UIKit
import Spring

protocol TRTrackerViewDelegate {
    func trackItemAt(row: Int)
}

protocol TRTrackerViewObserver {
    func displayDateChooser()
}

class TRTrackerView: UIView, TRTrackerTableViewCellDelegate {
    @IBOutlet weak var todaysDateButton: UIButton!
    @IBOutlet weak var recordSavedLabel: SpringLabel!
    @IBOutlet weak var trackerTableView: UITableView! {
        didSet {
            self.trackerTableView.delegate = self
        }
    }
    var pathToReload: NSIndexPath?
    var delegate: TRTrackerViewDelegate?
    var observer: TRTrackerViewObserver?
    var animations = [Int]()
    
    override func willMoveToWindow(newWindow: UIWindow?) {
        super.willMoveToWindow(newWindow)
        setTodaysDateButtonLabelWithText(TRDateFormatter.descriptionForToday)
        trackerTableView.showsVerticalScrollIndicator = false
    }
    
    @IBAction func todaysDateButtonPressed() {
        self.observer?.displayDateChooser()
    }
    
    func setTodaysDateButtonLabelWithText(text: String) {
        todaysDateButton.setTitle(text, forState: UIControlState.Normal)
    }
    
    private func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    // MARK: TRTrackerTableViewCellDelegate
    
    func plusButtonPressedAt(row: Int) {
        self.delegate?.trackItemAt(row)
        weak var weakSelf = self
        recordSavedLabel.hidden = false
        
        let animationIndex = animations.count
        animations.append(animationIndex)
        
        func zoomOut() {
            if weakSelf?.animations.count > 0 {
                if (weakSelf?.animations.count)! - 1 == (weakSelf?.animations[animationIndex])! {
                    weakSelf?.recordSavedLabel.animation = "zoomOut"
                    weakSelf?.recordSavedLabel.force = 1.0
                    weakSelf?.animations.removeAll()
                    weakSelf?.recordSavedLabel.animate()
                }
            }
        }
        
        recordSavedLabel.animation = "fadeInDown"
        recordSavedLabel.curve = "easeIn"
        recordSavedLabel.force = 0.1
        recordSavedLabel.animateNext { () -> () in
            weakSelf?.delay(1.5, closure: zoomOut)
        }
    }
}
