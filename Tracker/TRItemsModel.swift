import Foundation

class TRItemsModel {
    
    static let sharedInstanceOfItemsModel = TRItemsModel(itemService: TRItemService())
    var items: [TRItem] { return self.activeItems }
    private var activeItems = [TRItem]()
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
                    weakSelf?.activeItems = items
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
    }
    
    private func deleteAllItems() {
        itemService.deleteAllItemsFromPhone()
    }
    
    private func filterOutInactiveItems() {
        activeItems = activeItems.filter { $0.activated }
    }
}