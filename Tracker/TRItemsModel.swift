import Foundation

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
    
    private var itemService: TRItemService
    
    private init(itemService: TRItemService) {
        self.itemService = itemService
        TRItem()
        self.checkForItems()
    }
    
    private func checkForItems() {
        weak var weakSelf = self
        itemService.readAllItemsFromPhone {
            (objects, error) -> Void in
            if let items = objects as? [TRItem] {
                if (items.count != 0) {
                    weakSelf?._allItems = items
                    weakSelf?.filterItemsByActivated()
                    return
                }
            }
            weakSelf?.deleteAllItems()
            weakSelf?.saveAllItems()
        }
    }
    
    private func saveAllItems() {
        for item in TRTrackableItems.sinfulItems {
            itemService.createItemWithName(item, isAVice: true, measureUnit: nil)
        }
        for (_, items) in TRTrackableItems.regularItems {
            let itemName = items["name"]! as String
            let itemMeasureUnit = items["unit"]! as String
            itemService.createItemWithName(itemName, isAVice: false, measureUnit: itemMeasureUnit)
        }
        weak var weakSelf = self
        itemService.saveAll { (success, error) -> Void in
            if success {
                weakSelf?.checkForItems()
            }
        }
    }
    
    func updateItemsActiveStatusAtIndex(index: Int, activeStatus: Bool) {
        _allItems[index].activated = activeStatus
        filterItemsByActivated()
        itemService.updateItem(self.allItems[index], activeStatus: activeStatus)
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