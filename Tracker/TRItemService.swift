import Foundation
import Parse

class TRItemService {
    
    private var itemsToSave = [TRItem]()
    
    func createItemWithName(name: String, isAVice: Bool, measureUnit: String?) {
        let item = TRItem(className: "item")
        item.activated = true
        item.name = name
        item.isAVice = isAVice
        if let unit = measureUnit {
            item.measurementUnit = unit
        }
        itemsToSave.append(item)
    }
    
    func saveAll(completion: PFBooleanResultBlock?) {
        if let completionBlock = completion {
            TRItem.pinAllInBackground(itemsToSave, block: completionBlock)
            itemsToSave.removeAll()
        }
    }
    
    func readAllItemsFromPhone(completion: PFArrayResultBlock?) {
        let BackgroundRetrievalCompletion: PFArrayResultBlock = {
            (objects: [AnyObject]?, error: NSError?) in
            if let completionBlock = completion {
                completionBlock(objects, error)
            }
        }
        let query = PFQuery(className: "item")
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock(BackgroundRetrievalCompletion)
    }
    
    func updateItem(item: TRItem, activeStatus: Bool) {
        item.activated = activeStatus
        item.pinInBackgroundWithBlock(nil)
    }
    
    func updateItem(item: TRItem, viceStatus: Bool) {
        item.isAVice = viceStatus
        item.pinInBackgroundWithBlock(nil)
    }
    
    func updateItem(item: TRItem, name: String) {
        item.name = name
        item.pinInBackgroundWithBlock(nil)
    }
    
    func updateItem(item: TRItem, unit: String) {
        item.measurementUnit = unit
        item.pinInBackgroundWithBlock(nil)
    }
    
    func deleteItemFromPhone(item: TRItem, completion: PFBooleanResultBlock?) {
        if let completionBlock = completion {
            item.unpinInBackgroundWithBlock(completionBlock)
        } else {
            item.unpinInBackgroundWithBlock(nil)
        }
    }
    
    func deleteAllItemsFromPhone() {
        TRItem.unpinAllObjects()
    }
    
}