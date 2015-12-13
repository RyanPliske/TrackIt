import UIKit
import Parse

/**
    TRRecord saves Track Records for a user specified item.
*/

class TRRecord: PFObject, PFSubclassing {
    
    let itemNameReference = "item"
    let itemQuantityReference = "quantity"
    let itemTypeReference = "type"
    let itemDateDescription = "date"
    let itemDateReference = "nsdate"

    override class func initialize() {
        struct Static {
            static var onceToken: dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
                self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String {
        return "record"
    }
    // MARK: Properties
    var itemName: String? {
        get {
            return self[itemNameReference] as? String
        }
        set(newValue) {
            self[itemNameReference] = newValue
        }
    }
    
    var itemQuantity: Float {
        get {
            if let quantity = self[itemQuantityReference] as? Float {
                return quantity
            } else {
                return 0.0
            }
        }
        set(newValue) {
            self[itemQuantityReference] = newValue
        }
    }
    
    var dateDescription: String {
        get {
            if let date = self[itemDateDescription] as? String {
                return date
            } else {
                return ""
            }
        }
        set(newValue) {
            self[itemDateDescription] = newValue
        }
    }
    
    var date: NSDate? {
        get {
            return self[itemDateReference] as? NSDate
        }
        set(newValue) {
            self[itemDateReference] = newValue
        }
    }
}