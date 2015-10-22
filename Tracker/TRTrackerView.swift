import UIKit
import TPKeyboardAvoiding
import Spring

protocol TRTrackerViewDelegate {
    func trackItemAtRow(row: Int)
    func trackUrgeAtRow(row: Int)
    func trackMultipleSelectedForRow(row: Int)
    func textFieldReturnedWithTextAtRow(row: Int, text: String)
    func itemSelectedAtRow(row: Int)
}

protocol TRTrackerViewObserver {
    func dateChooserWanted()
    func trackingOptionsWantedAtRow(row: Int, includeBadHabit: Bool)
    func dismissTrackingOptions()
}

class TRTrackerView: UIView, TRTrackerTableViewCellDelegate {
    @IBOutlet weak var todaysDateButton: UIButton!
    @IBOutlet weak var recordSavedLabel: SpringLabel!
    @IBOutlet weak var trackerTableView: TPKeyboardAvoidingTableView! {
        didSet {
            self.trackerTableView.delegate = self
        }
    }
    var pathToReload: NSIndexPath?
    var delegate: TRTrackerViewDelegate?
    var observer: TRTrackerViewObserver?
    var animations = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTodaysDateButtonLabelWithText(TRDateFormatter.descriptionForToday)
        trackerTableView.showsVerticalScrollIndicator = false
    }
    
    @IBAction func todaysDateButtonPressed() {
        observer?.dateChooserWanted()
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
    
    private func animateSavedRecordForRow(row: Int) {
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
        
        recordSavedLabel.textColor = TRColorGenerator.colorFor(row)
        recordSavedLabel.animation = "fadeInDown"
        recordSavedLabel.curve = "easeIn"
        recordSavedLabel.force = 0.1
        recordSavedLabel.animateNext { () -> () in
            weakSelf?.delay(1.5, closure: zoomOut)
        }
    }
    
    // MARK: TRTrackerTableViewCellDelegate
    
    func plusButtonPressedAtRow(row: Int) {
        delegate?.trackItemAtRow(row)
        animateSavedRecordForRow(row)
    }
    
    func moreButtonPressedAtRow(row: Int, includeBadHabit: Bool) {
        observer?.trackingOptionsWantedAtRow(row, includeBadHabit: includeBadHabit)
    }
    
    func trackUrgeSelectedForRow(row: Int) {
        delegate?.trackUrgeAtRow(row)
        observer?.dismissTrackingOptions()
        animateSavedRecordForRow(row)
    }
    
    func trackMultipleSelectedForRow(row: Int) {
        delegate?.trackMultipleSelectedForRow(row)
        observer?.dismissTrackingOptions()
    }
    
    func textFieldReturnedWithTextAtRow(row: Int, text: String) {
        delegate?.textFieldReturnedWithTextAtRow(row, text: text)
        animateSavedRecordForRow(row)
    }
}
