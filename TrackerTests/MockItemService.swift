import Foundation
import Parse

class MockItemService : TRItemService {
    
    override func saveAll(completion: PFBooleanResultBlock?) {
        
    }
    
    override func readAllItemsFromPhone(completion: PFArrayResultBlock?) {
        let item1 = TRItem(className: "item")
        item1.name = "requiredName"
        let item2 = TRItem(className: "item")
        item2.name = "requiredName"
        let items = [item1, item2]
        if let completionBlock = completion {
            completionBlock(items, nil)
        }
    }
    
    override func updateItem(item: TRItem, activeStatus: Bool) {
        
    }
    
    override func updateItem(item: TRItem, name: String) {
        
    }
    
    override func updateItem(item: TRItem, unit: String) {
        
    }
    
    override func updateItem(item: TRItem, viceStatus: Bool) {

    }
    
    override func deleteItemFromPhone(item: TRItem, completion: PFBooleanResultBlock?) {
        
    }
    
    override func deleteAllItemsFromPhone() {
        
    }
}