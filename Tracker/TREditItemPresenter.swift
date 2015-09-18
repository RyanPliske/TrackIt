import Foundation

class TREditItemPresenter: NSObject, UITableViewDataSource, UITableViewDelegate, TREditItemTableViewInputCellDelegate, TREditItemTableViewViceCellDelegate {
    private let editItemTableView: UITableView
    private let itemsModel: TRItemsModel
    private var itemRow: Int?
    private var isNewItem = false
    private var isPreloadedItem = false
    private enum cellIndex: Int {
        case itemName = 0
        case itemUnit = 1
        case itemGoal = 2
        case itemVice = 3
        
        static let allCellItems = [itemName, itemUnit, itemGoal, itemVice]
    }
    
    init(view: UITableView, itemRowToPopulateWith: Int?, itemsModel: TRItemsModel) {
        self.editItemTableView = view
        self.itemRow = itemRowToPopulateWith
        self.itemsModel = itemsModel
        if self.itemRow == nil {
            self.isNewItem = true
        } else {
            self.isPreloadedItem = self.itemRow <= TRPreloadedItems.allItems.count ? true : false
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
        if let badHabitCell = editItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: cellIndex.itemVice.rawValue, inSection: 0)) as? TREditItemTableViewViceCell {
            badHabitCell.setViewSwitchUserInteraction(true)
        }
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellIndex.allCellItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch (indexPath.row) {
        case cellIndex.itemName.rawValue:
            cell = tableView.dequeueReusableCellWithIdentifier("userInputCell") as! TREditItemTableViewInputCell
            if let inputCell = cell as? TREditItemTableViewInputCell {
                inputCell.topBorder.hidden = false
                inputCell.setLabelWithText("Name:")
                let textFieldText = isNewItem ? "" : itemsModel.allItems[itemRow!].name
                inputCell.setTextFieldTextWithText(textFieldText)
                inputCell.setTextFieldTagWith(indexPath.row)
                inputCell.textFieldDelegate = self
                if isNewItem {
                    inputCell.setTextFieldAsFirstResponder()
                } else if isPreloadedItem {
                    inputCell.setTextFieldUserInteraction(false)
                }
            }
        case cellIndex.itemUnit.rawValue:
            cell = tableView.dequeueReusableCellWithIdentifier("userInputCell") as! TREditItemTableViewInputCell
            if let inputCell = cell as? TREditItemTableViewInputCell {
                inputCell.setLabelWithText("Measure Unit:")
                let textFieldText = isNewItem ? "" : itemsModel.allItems[itemRow!].measurementUnit
                inputCell.setTextFieldTextWithText(textFieldText)
                inputCell.setTextFieldTagWith(indexPath.row)
                inputCell.textFieldDelegate = self
                if isNewItem {
                    inputCell.setTextFieldUserInteraction(false)
                } else if isPreloadedItem {
                    inputCell.setTextFieldUserInteraction(false)
                }
            }
        case cellIndex.itemGoal.rawValue:
            cell = tableView.dequeueReusableCellWithIdentifier("userInputCell") as! TREditItemTableViewInputCell
            if let inputCell = cell as? TREditItemTableViewInputCell {
                inputCell.setLabelWithText("Set a Daily Goal:")
                inputCell.setTextFieldTagWith(indexPath.row)
                inputCell.setTextFieldKeyboardTypeToNumberPad()
                inputCell.textFieldDelegate = self
                if isNewItem {
                    inputCell.setTextFieldUserInteraction(false)
                } else {
                    let textFieldText = (itemsModel.allItems[itemRow!].dailyGoal == nil) ? "" : "\(itemsModel.allItems[itemRow!].dailyGoal!)"
                    inputCell.setTextFieldTextWithText(textFieldText)
                }
            }
        case cellIndex.itemVice.rawValue:
            cell = tableView.dequeueReusableCellWithIdentifier("badHabitCell") as! TREditItemTableViewViceCell
            if let viceCell = cell as? TREditItemTableViewViceCell {
                viceCell.bottomBorder.hidden = false
                let isAVice = isNewItem ? false : itemsModel.allItems[itemRow!].isAVice
                viceCell.setViceSwitchTo(isAVice)
                viceCell.viceSwitchDelegate = self
                if isNewItem {
                    viceCell.setViewSwitchUserInteraction(false)
                } else if isPreloadedItem {
                    viceCell.setViewSwitchUserInteraction(false)
                }
            }
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("userInputCell") as! TREditItemTableViewInputCell
            
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == cellIndex.itemVice.rawValue {
            return 50.0
        } else {
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
                    NSNotificationCenter.defaultCenter().postNotificationName("newItem", object: nil)
                })
            }
        } else {
            if row == cellIndex.itemName.rawValue {
                itemsModel.updateItemNameAtIndex(itemRow!, name: text)
            } else if row == cellIndex.itemUnit.rawValue {
                if text.isEmpty {
                    itemsModel.updateItemMeasurementUnitAtIndex(itemRow!, unit: nil)
                } else {
                   itemsModel.updateItemMeasurementUnitAtIndex(itemRow!, unit: text)
                }
            } else if row == cellIndex.itemGoal.rawValue {
                if let goal = Int(text) {
                    itemsModel.updateItemGoalAtIndex(itemRow!, goal: goal)
                } else if text.isEmpty {
                    itemsModel.updateItemGoalAtIndex(itemRow!, goal: nil)
                }
            }
        }
    }
    
    // MARK: TREditItemTableViewViceCellDelegate
    func toggleSwitchChangedValueAtRow() {
        if let badHabitCell = editItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: cellIndex.itemVice.rawValue, inSection: 0)) as? TREditItemTableViewViceCell {
            itemsModel.updateItemViceStatusAtIndex(itemRow!, viceStatus: badHabitCell.viceSwitchState)
        }
    }
    
}