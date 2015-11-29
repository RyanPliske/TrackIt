import Foundation

protocol TRItemsModelDelegate: class {
    func itemOpenedStatusChangedAtIndex(index: Int)
    func itemTrackByOneStatusChangedAtIndex(index: Int)
}

class TRItemsModel {
    
    static let sharedInstanceOfItemsModel = TRItemsModel(itemService: TRItemService())
    var allItems: [TRItem] { return self._allItems }
    private var _allItems = [TRItem]()
    var activeItems: [TRItem] { return self._activeItems }
    private var _activeItems = [TRItem]()
    var activeSinfulItems: [TRItem] { return self._sinfulItems }
    private var _sinfulItems = [TRItem]()
    var activeRegularItems: [TRItem] { return self._regularItems }
    private var _regularItems = [TRItem]()
    var delegate: TRItemsModelDelegate!
    
    private var itemService: TRItemService
    
    init(itemService: TRItemService) {
        self.itemService = itemService
        readItemsFromPhone { () -> () in
            NSNotificationCenter.defaultCenter().postNotificationName("itemsRetrievedFromDB", object: nil)
        }
    }
    
    private func preloadItemsToPhone() {
        var itemCount = 0
        for item in TRPreloadedItems.sinfulItems {
            itemService.addItemToSaveWithItemName(item, measureUnit: nil, incrementByOne: true, index: itemCount)
            itemCount++
        }
        for (_, items) in TRPreloadedItems.regularItems {
            let itemName = items["name"] as! String
            let itemMeasureUnit = items["unit"] as! String
            let incrementByOne = items["increment"] as! Bool
            itemService.addItemToSaveWithItemName(itemName, measureUnit: itemMeasureUnit, incrementByOne: incrementByOne, index: itemCount)
            itemCount++
        }
        weak var weakSelf = self
        itemService.saveItems { (success, error) -> Void in
            if success {
                weakSelf?.readItemsFromPhone({ () -> () in
                    NSNotificationCenter.defaultCenter().postNotificationName("itemsRetrievedFromDB", object: nil)
                })
            }
        }
    }
    
    func createItemWithName(itemName: String, completion: (()->())?) {
        itemService.addItemToSaveWithItemName(itemName, measureUnit: nil, incrementByOne: true, index: _allItems.count - 1)
        itemService.saveItems { [weak self](success, error) -> Void in
            if success {
                self?.readItemsFromPhone(completion)
            }
        }
    }
    
    private func readItemsFromPhone(completion: (() -> ())?) {
        weak var weakSelf = self
        itemService.readAllItemsFromPhone { (items: [TRItem]) -> Void in
            // Items should only be empty upond installation of the app.
            if items.isEmpty {
                weakSelf?.deleteAllItems()
                weakSelf?.preloadItemsToPhone()
            } else {
                weakSelf?._allItems = items
                weakSelf?.orderAllItems()
                weakSelf?.filterItemsByActivated()
                if let completionBlock = completion {
                    completionBlock()
                }
            }
        }
    }
    
    func updateItemActiveStatusAtIndex(index: Int, activeStatus: Bool) {
        _allItems[index].activated = activeStatus
        filterItemsByActivated()
        itemService.updateItem(self.allItems[index], activeStatus: activeStatus)
    }
    
    func updateItemIncrementalStatusAtIndex(index: Int, status: Bool) {
        _allItems[index].incrementByOne = status
        itemService.updateItem(self.allItems[index], incrementByOne: status)
        // only update main view if item is active
        let filter = _activeItems.filter { $0 == _allItems[index] }.first
        if let itemToUpdate = filter {
            delegate.itemTrackByOneStatusChangedAtIndex(_activeItems.indexOf(itemToUpdate)!)
        }
    }
    
    func updateItemNameAtIndex(index: Int, name: String) {
        _allItems[index].name = name
        itemService.updateItem(self.allItems[index], name: name)
    }
    
    func updateItemOpenedStatusAtIndex(index: Int) {
        self._activeItems[index].opened = !self._activeItems[index].opened
        delegate.itemOpenedStatusChangedAtIndex(index)
    }
    
    func updateItemMeasurementUnitAtIndex(index: Int, unit: String?) {
        if let aUnit = unit {
            _allItems[index].measurementUnit = aUnit
        } else {
            _allItems[index]["unit"] = NSNull()
        }
        itemService.updateItem(self.allItems[index], unit: unit)
    }
    
    func updateItemGoalAtIndex(index: Int, goal: Int?) {
        if let aGoal = goal {
            _allItems[index].dailyGoal = aGoal
        } else {
            _allItems[index]["dailyGoal"] = NSNull()
        }
        itemService.updateItem(self.allItems[index], goal: goal)
        
    }
    
    func updateItemDailyGoalTypeAtIndex(index: Int, goalType: DailyGoalType) {
        _allItems[index].dailyGoalType = goalType
        let itemToUpdate = _allItems[index]
        itemService.updateItem(itemToUpdate, dailyGoalType: goalType)
    }
    
    func exchangeItemAtIndex(sourceIndex: Int, withItemAtIndex newIndex: Int) {
        let tempItem = _allItems[sourceIndex]
        _allItems.removeAtIndex(sourceIndex)
        _allItems.insert(tempItem, atIndex: newIndex)
        updateIndexes()
        print(_allItems)
        
        filterItemsByActivated()
    }
    
    func deleteItemAtIndex(index: Int) {
        let itemToDelete = _allItems[index]
        _allItems = _allItems.filter { $0 !== itemToDelete }
        updateIndexes()

        itemService.deleteItemFromPhone(itemToDelete) { [weak self](success, error) -> Void in
            if success {
                self?.readItemsFromPhone(nil)
            }
        }
    }
    
    private func deleteAllItems() {
        itemService.deleteAllItemsFromPhone()
    }
    
    private func filterItemsByActivated() {
        _activeItems = _allItems.filter { $0.activated }
        NSNotificationCenter.defaultCenter().postNotificationName("ActiveItemsChanged", object: nil)
    }
    
    private func orderAllItems() {
        _allItems = _allItems.sort { $0.0.index < $0.1.index }
    }
    
    private func updateIndexes() {
        var count = 0
        for item in _allItems {
            item.index = count
            count++
        }
    }
}