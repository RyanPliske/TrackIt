import Foundation
import Parse

class TRRecord: PFObject, PFSubclassing {
    // MARK: Parse Setup
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
            return self["item"] as? String
        }
        set(newValue) {
            self["item"] = newValue
        }
    }
    
    var itemQuantity: Int? {
        get {
            return self["quantity"] as? Int
        }
        set(newValue) {
            self["quantity"] = newValue
        }
    }
    
    var itemType: String? {
        get {
            return self["type"] as? String
        }
        set(newValue) {
            self["type"] = newValue
        }
    }
    
    var itemDate: String? {
        get {
            return self["date"] as? String
        }
        set(newValue) {
            self["date"] = newValue
        }
    }
}