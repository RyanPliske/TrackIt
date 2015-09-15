import Foundation
import Parse

class TRItemService {
    
    func createItemWithName(name: String, isAVice: Bool) -> TRItem {
        let item = TRItem(className: "item")
        item.activated = true
        item.name = name
        item.isAVice = isAVice
        saveItemToPhoneWithItem(item)
        return item
    }
    
    func readAllItemsFromPhone(completion: PFArrayResultBlock?) {
        let BackgroundRetrievalCompletion: PFQueryArrayResultBlock? = {
            (objects: [PFObject]?, error: NSError?) in
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
    
    func deleteAllItemsFromPhone() {
        do {
          try TRItem.unpinAllObjects()
        } catch {
            
        }
    }
    
    private func saveItemToPhoneWithItem(item: TRItem) {
        item.pinInBackgroundWithBlock(nil)
    }
    
}