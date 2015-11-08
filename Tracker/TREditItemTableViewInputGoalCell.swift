import Foundation

protocol TREditItemTableViewInputGoalCellDelegate: class {
    func dailyGoalTypeChangedAtRow(row: Int, goalType: DailyGoalType)
}

class TREditItemTableViewInputGoalCell: TREditItemTableViewInputCell {
    
    @IBOutlet weak var maxButton: UIButton!
    @IBOutlet weak var minButton: UIButton!
    
    @IBAction func maxButtonPressed(sender: AnyObject) {
        setupMaxState()
        cellDelegate.dailyGoalTypeChangedAtRow(tag, goalType: DailyGoalType.Max)
    }
    
    
    @IBAction func minButtonPressed(sender: AnyObject) {
        setupMinState()
        cellDelegate.dailyGoalTypeChangedAtRow(tag, goalType: DailyGoalType.Min)
    }
    
    func setDailyGoalType(dailyGoalType: DailyGoalType) {
        switch dailyGoalType {
        case .Max:
            setupMaxState()
        case .Min:
            setupMinState()
        }
    }
    
    private func setupMaxState() {
        maxButton.setTitleColor(UIColor.TRMimosaYellow(), forState: .Normal)
        minButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    }
    
    private func setupMinState() {
        maxButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        minButton.setTitleColor(UIColor.TRMimosaYellow(), forState: .Normal)
    }
    
}