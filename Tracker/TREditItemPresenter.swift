import Foundation

class TREditItemPresenter: NSObject, UITableViewDataSource, UITableViewDelegate, TREditItemTableViewInputCellDelegate, TREditItemTableViewViceCellDelegate {
    private let editItemTableView: UITableView
    private let itemsModel: TRItemsModel
    private var itemRow: Int!
    private var isNewItem = false
    private enum cellIndex: Int {
        case itemName = 0
        case itemUnit = 1
        case itemGoal = 3
        case incrementByOne = 2
        
        static var numberOfCells: Int {
            var count = 0
            while let _ = cellIndex(rawValue: ++count) {}
            return count
        }
    }
    
    init(view: UITableView, itemRowToPopulateWith: Int?, itemsModel: TRItemsModel) {
        self.editItemTableView = view
        self.itemRow = itemRowToPopulateWith
        self.itemsModel = itemsModel
        if self.itemRow == nil {
            self.isNewItem = true
        }
        super.init()
        self.editItemTableView.dataSource = self
        self.editItemTableView.delegate = self
    }
    
    private func enableOtherCells() {
        if let secondInputCell = editItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: cellIndex.itemUnit.rawValue, inSection: 0)) as? TREditItemTableViewInputCell {
            secondInputCell.setTextFieldUserInteraction(true)
        }
        if let thirdInputCell = editItemTableView.cellForRowAtIndexPath(NSIndexPath(forItem: cellIndex.itemGoal.rawValue, inSection: 0)) as? TREditItemTableViewInputCell {
            thirdInputCell.setTextFieldUserInteraction(true)
        }
        if let trackByOneCell = editItemTableView.cellForRowAtIndexPath(NSIndexPath(forItem: cellIndex.incrementByOne.rawValue, inSection: 0)) as? TREditItemTableViewTrackByOneCell {
            trackByOneCell.setUserInteraction(true)
            trackByOneCell.setSwitchTo(true)
        }
    }
    
    func fuckingResignFirstResponder() {
        for cells in editItemTableView.visibleCells {
            if let cell = cells as? TREditItemTableViewInputCell {
                cell.textField.resignFirstResponder()
            }
        }
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellIndex.numberOfCells
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch (indexPath.row) {
        case cellIndex.itemName.rawValue:
            cell = tableView.dequeueReusableCellWithIdentifier("userInputCell") as! TREditItemTableViewInputCell
            if let inputCell = cell as? TREditItemTableViewInputCell {
                inputCell.topBorder.hidden = false
                inputCell.setLabelWithText("Name:")
                let textFieldText = isNewItem ? "" : itemsModel.allItems[itemRow].name
                inputCell.setTextFieldTextWithText(textFieldText)
                inputCell.setTextFieldTagWith(indexPath.row)
                inputCell.cellDelegate = self
                if isNewItem {
                    inputCell.setTextFieldAsFirstResponder()
                } else {
                    inputCell.setTextFieldUserInteraction(false)
                }
            }
        case cellIndex.itemUnit.rawValue:
            cell = tableView.dequeueReusableCellWithIdentifier("userInputCell") as! TREditItemTableViewInputCell
            if let inputCell = cell as? TREditItemTableViewInputCell {
                inputCell.setLabelWithText("Measure Unit:")
                let textFieldText = isNewItem ? "" : itemsModel.allItems[itemRow].measurementUnit
                inputCell.setTextFieldTextWithText(textFieldText)
                inputCell.setTextFieldTagWith(indexPath.row)
                inputCell.cellDelegate = self
                if isNewItem {
                    inputCell.setTextFieldUserInteraction(false)
                }
            }
        case cellIndex.itemGoal.rawValue:
            cell = tableView.dequeueReusableCellWithIdentifier("goalCell") as! TREditItemTableViewInputGoalCell
            if let inputCell = cell as? TREditItemTableViewInputGoalCell {
                inputCell.setLabelWithText("Set a Daily Goal:")
                inputCell.setTextFieldTagWith(indexPath.row)
                inputCell.setTextFieldKeyboardTypeToNumberPad()
                inputCell.cellDelegate = self
                if isNewItem {
                    inputCell.setTextFieldUserInteraction(false)
                } else {
                    let textFieldText = (itemsModel.allItems[itemRow].dailyGoal == nil) ? "" : "\(itemsModel.allItems[itemRow].dailyGoal!)"
                    inputCell.setTextFieldTextWithText(textFieldText)
                }
                if let row = itemRow {
                    inputCell.tag = row
                    inputCell.setDailyGoalType(itemsModel.allItems[row].dailyGoalType)
                }
            }
        case cellIndex.incrementByOne.rawValue:
            cell = tableView.dequeueReusableCellWithIdentifier("trackByOne") as! TREditItemTableViewTrackByOneCell
            if let trackByOneCell = cell as? TREditItemTableViewTrackByOneCell {
                let trackByOne = isNewItem ? false : itemsModel.allItems[itemRow].incrementByOne
                trackByOneCell.setSwitchTo(trackByOne)
                trackByOneCell.trackByOneSwitchDelegate = self
                if isNewItem {
                    trackByOneCell.setUserInteraction(false)
                } else {
                    trackByOneCell.setUserInteraction(true)
                }
            }
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("userInputCell") as! TREditItemTableViewInputCell
            
        }
        if indexPath.row == cellIndex.numberOfCells - 1 {
            (cell as! TRSettingsTableViewCell).bottomBorder.hidden = false
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == cellIndex.incrementByOne.rawValue {
            return 60.0
        }
        else {
            return heightForUserInputCell()
        }
    }
    
    // MARK: UITableViewHeightCalculation Helpers
    private func heightForUserInputCell() -> CGFloat {
        
        struct Static {
            static var userInputCell: UITableViewCell? = nil
            static var onceToken: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.onceToken, {
            Static.userInputCell = self.editItemTableView.dequeueReusableCellWithIdentifier("userInputCell")
        })
        
        return calculateHeightForConfiguredUserInputCell(Static.userInputCell!)
    }
    
    private func calculateHeightForConfiguredUserInputCell(cell: UITableViewCell) -> CGFloat {
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size = cell.contentView .systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        return size.height + 1.0
    }
    
    // MARK: TREditItemTableViewInputCellDelegate
    func textFieldChangedAtRow(row: Int, text: String) {
        if isNewItem {
            if !text.isEmpty {
                enableOtherCells()
                weak var weakSelf = self
                itemsModel.createItemWithName(text, completion: { () -> () in
                    weakSelf?.isNewItem = false
                    weakSelf?.itemRow = ((weakSelf?.itemsModel.allItems.count)! - 1)
                    NSNotificationCenter.defaultCenter().postNotificationName("ActiveItemsChanged", object: nil)
                })
            }
        } else {
            if row == cellIndex.itemName.rawValue {
                itemsModel.updateItemNameAtIndex(itemRow, name: text)
            } else if row == cellIndex.itemUnit.rawValue {
                if text.isEmpty {
                    itemsModel.updateItemMeasurementUnitAtIndex(itemRow, unit: nil)
                } else {
                   itemsModel.updateItemMeasurementUnitAtIndex(itemRow, unit: text)
                }
            } else if row == cellIndex.itemGoal.rawValue {
                if let goal = Int(text) {
                    itemsModel.updateItemGoalAtIndex(itemRow, goal: goal)
                } else if text.isEmpty {
                    itemsModel.updateItemGoalAtIndex(itemRow, goal: nil)
                }
            }
        }
    }
    
    func dailyGoalTypeChangedAtRow(row: Int, goalType: DailyGoalType) {
        itemsModel.updateItemDailyGoalTypeAtIndex(row, goalType: goalType)
    }
    
    // MARK: TREditItemTableViewViceCellDelegate
    func toggleSwitchChangedToValue(value: Bool) {
        itemsModel.updateItemIncrementalStatusAtIndex(itemRow, status: value)
    }
    
}