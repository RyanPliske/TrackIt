import Foundation

class TREditItemPresenter: NSObject, UITableViewDataSource, UITableViewDelegate {
    let itemTableView: UITableView
    let itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    let itemRow: Int
    
    init(view: UITableView, itemRowToPopulateWith: Int) {
        self.itemTableView = view
        self.itemRow = itemRowToPopulateWith
        super.init()
        self.itemTableView.dataSource = self
        self.itemTableView.delegate = self
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch (indexPath.row) {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("userInputCell") as! TREditItemTableViewCell
            if let inputCell = cell as? TREditItemTableViewCell {
                inputCell.topBorder.hidden = false
                inputCell.setLabelWithText("Name:")
                inputCell.setTextFieldTextWithText(itemsModel.allItems[itemRow].name)
            }
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("badHabitCell")!
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("userInputCell") as! TREditItemTableViewCell
            if let inputCell = cell as? TREditItemTableViewCell {
                inputCell.bottomBorder.hidden = false
                inputCell.setLabelWithText("Measure Unit:")
                inputCell.setTextFieldTextWithText(itemsModel.allItems[itemRow].name)
            }
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("userInputCell") as! TREditItemTableViewCell
            
        }
        return cell
    }
    
    // MARK: UITableView
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 2 {
            let heightForRow = heightForUserInputCell()
            return heightForRow
        } else {
            return 50.0
        }
    }
    
    // MARK: UITableViewHeightCalculation Helpers
    private func heightForUserInputCell() -> CGFloat {
        
        struct Static {
            static var userInputCell: UITableViewCell? = nil
            static var onceToken: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.onceToken, {
            Static.userInputCell = self.itemTableView.dequeueReusableCellWithIdentifier("userInputCell")
        })
        
        return calculateHeightForConfiguredUserInputCell(Static.userInputCell!)
    }
    
    private func calculateHeightForConfiguredUserInputCell(cell: UITableViewCell) -> CGFloat {
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size = cell.contentView .systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        return size.height + 1.0
    }
    
}