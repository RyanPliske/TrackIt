import Foundation

class TREditItemPresenter: NSObject, UITableViewDataSource, UITableViewDelegate, TREditItemTableViewInputCellDelegate {
    private let itemTableView: UITableView
    private let itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    private var itemRow: Int?
    private var isNewItem = false
    private enum cellIndex: Int {
        case itemName = 0
        case itemVice = 1
        case itemUnit = 2
    }
    
    init(view: UITableView, itemRowToPopulateWith: Int?) {
        self.itemTableView = view
        self.itemRow = itemRowToPopulateWith
        if self.itemRow == nil {
            self.isNewItem = true
        }
        super.init()
        self.itemTableView.dataSource = self
        self.itemTableView.delegate = self
    }
    
    private func enableOtherCells() {
        if let secondInputCell = itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: cellIndex.itemUnit.rawValue, inSection: 0)) as? TREditItemTableViewInputCell {
            secondInputCell.setTextFieldUserInteraction(true)
        }
        if let badHabitCell = itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: cellIndex.itemVice.rawValue, inSection: 0)) as? TREditItemTableViewViceCell {
            badHabitCell.setViewSwitchUserInteraction(true)
        }
    }
    
    private func setTagForNewItem() {
        if let firstInputCell = itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: cellIndex.itemUnit.rawValue, inSection: 0)) as? TREditItemTableViewInputCell {
            firstInputCell.setTextFieldTagWith(itemsModel.allItems.count + 1)
        }
        if let secondInputCell = itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: cellIndex.itemUnit.rawValue, inSection: 0)) as? TREditItemTableViewInputCell {
            secondInputCell.setTextFieldTagWith(itemsModel.allItems.count + 1)
        }
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
                }
            }
        case cellIndex.itemVice.rawValue:
            cell = tableView.dequeueReusableCellWithIdentifier("badHabitCell") as! TREditItemTableViewViceCell
            if let viceCell = cell as? TREditItemTableViewViceCell {
                let isAVice = isNewItem ? false : itemsModel.allItems[itemRow!].isAVice
                viceCell.setViceSwitchTo(isAVice)
                if isNewItem {
                    viceCell.setViewSwitchUserInteraction(false)
                }
            }
        case cellIndex.itemUnit.rawValue:
            cell = tableView.dequeueReusableCellWithIdentifier("userInputCell") as! TREditItemTableViewInputCell
            if let inputCell = cell as? TREditItemTableViewInputCell {
                inputCell.bottomBorder.hidden = false
                inputCell.setLabelWithText("Measure Unit:")
                let textFieldText = isNewItem ? "" : itemsModel.allItems[itemRow!].measurementUnit
                inputCell.setTextFieldTextWithText(textFieldText)
                inputCell.setTextFieldTagWith(indexPath.row)
                inputCell.textFieldDelegate = self
                if isNewItem {
                    inputCell.setTextFieldUserInteraction(false)
                }
            }
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("userInputCell") as! TREditItemTableViewInputCell
            
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == cellIndex.itemName.rawValue || indexPath.row == cellIndex.itemUnit.rawValue {
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
    
    // MARK: TREditItemTableViewInputCellDelegate
    func textFieldChangedAtRow(row: Int, text: String) {
        if isNewItem {
            enableOtherCells()
            itemsModel.createItemWithName(text)
            isNewItem = false
            setTagForNewItem()
        } else {
            if row == cellIndex.itemName.rawValue {
                itemsModel.updateItemsNameAtIndex(itemRow!, name: text)
            } else if row == cellIndex.itemUnit.rawValue {
                itemsModel.updateItemsMeasurementUnitAtIndex(itemRow!, unit: text)
            }
        }
    }
    
}