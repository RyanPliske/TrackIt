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
        self.checkForItems()
    }
    
    private func checkForItems() {
        weak var weakSelf = self
        itemService.readAllItemsFromPhone {
            (objects, error) -> Void in
            if let unwrappedObjects = objects {
                if (unwrappedObjects.count != 0) {
                    let items = objects as! [TRItem]
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
            itemService.createItemWithName(item, isAVice: true)
        }
        for item in TRTrackableItems.regularItems {
            itemService.createItemWithName(item, isAVice: false)
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
        _sinfulItems = activeItems.filter { $0.isAVice }
        _regularItems = activeItems.filter { !$0.isAVice }
    }
    
    private func filterItemsByActivated() {
        _activeItems = allItems.filter { $0.activated }
        filterActiveItemsByVice()
    }
}