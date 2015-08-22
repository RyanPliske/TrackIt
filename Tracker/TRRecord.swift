import Foundation
import Parse

class TRRecord: PFObject, PFSubclassing {
    
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
    
    var itemDate: NSDate? {
        get {
            return self["date"] as? NSDate
        }
        set(newValue) {
            self["date"] = newValue
        }
    }
    
    // MARK: Helper
    static func itemTypeFrom(type: TRTrackingType) -> String {
        return (type == TRTrackingType.TrackAction) ? "action" : "urge"
    }
    
}