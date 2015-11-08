import Foundation

protocol TRItemsModelDelegate: class {
    func itemOpenedStatusChangedAtIndex(index: Int)
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
        for item in TRPreloadedItems.sinfulItems {
            itemService.addItemToSaveWithItemName(item, isAVice: true, measureUnit: nil)
        }
        for (_, items) in TRPreloadedItems.regularItems {
            let itemName = items["name"] as! String
            let itemMeasureUnit = items["unit"] as! String
            let incrementByOne = items["increment"] as! Bool
            if incrementByOne {
                itemService.addItemToSaveWithItemName(itemName, isAVice: false, measureUnit: itemMeasureUnit)
            } else {
                itemService.addItemToSaveWithItemName(itemName, isAVice: false, measureUnit: itemMeasureUnit, incrementByOne: false)
            }
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
        itemService.addItemToSaveWithItemName(itemName, isAVice: false, measureUnit: nil)
        weak var weakSelf = self
        itemService.saveItems { (success, error) -> Void in
            if success {
                weakSelf?.readItemsFromPhone(completion)
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
        NSNotificationCenter.defaultCenter().postNotificationName("ActiveItemsChanged", object: nil)
    }
    
    func updateItemIncrementalStatusAtIndex(index: Int) {
        let incrementByOne = !_activeItems[index].incrementByOne
        _activeItems[index].incrementByOne = incrementByOne
        itemService.updateItem(self.allItems[index], incrementByOne: incrementByOne)
    }
    
    func updateItemNameAtIndex(index: Int, name: String) {
        _allItems[index].name = name
        itemService.updateItem(self.allItems[index], name: name)
    }
    
    func updateItemViceStatusAtIndex(index: Int, viceStatus: Bool) {
        _allItems[index].isAVice = viceStatus
        filterActiveItemsByVice()
        itemService.updateItem(self.allItems[index], viceStatus: viceStatus)
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
    
    func deleteItemAtIndex(index: Int) {
        let itemToDelete = _allItems[index]
        _allItems = _allItems.filter { $0 !== itemToDelete }
        weak var weakSelf = self
        itemService.deleteItemFromPhone(itemToDelete) { (success, error) -> Void in
            if success {
                weakSelf?.readItemsFromPhone(nil)
            }
        }
    }
    
    private func deleteAllItems() {
        itemService.deleteAllItemsFromPhone()
    }
    
    private func filterActiveItemsByVice() {
        _sinfulItems = _activeItems.filter { $0.isAVice }
        _regularItems = _activeItems.filter { !$0.isAVice }
    }
    
    private func filterItemsByActivated() {
        _activeItems = _allItems.filter { $0.activated }
        filterActiveItemsByVice()
    }
}