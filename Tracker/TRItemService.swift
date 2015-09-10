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
    
    func deleteAllItemsFromPhone() {
        TRItem.unpinAllObjects()
    }
    
    private func saveItemToPhoneWithItem(item: TRItem) {
        item.pinInBackgroundWithBlock(nil)
    }
    
}