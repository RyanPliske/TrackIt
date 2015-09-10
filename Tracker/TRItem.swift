import Foundation
import Parse

class TRItem: PFObject, PFSubclassing {
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
        return "item"
    }
    // MARK: Properties
    var name: String? {
        get {
            return self["name"] as? String
        }
        set(newValue) {
            self["name"] = newValue
        }
    }
    
    var activated: Bool? {
        get {
            if let status = self["activated"] as? Bool {
                return status
            }
            else {
                return true
            }
        }
        set(newValue) {
            self["activated"] = newValue
        }
    }
    
    var isAVice: Bool? {
        get {
            if let status = self["vice"] as? Bool {
                return status
            }
            else {
                return true
            }
        }
        set(newValue) {
            self["vice"] = newValue
        }
    }
    
}