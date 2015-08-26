import Foundation
import Parse

public class TRRecord: PFObject, PFSubclassing {
    // MARK: Parse Setup
    override public class func initialize() {
        struct Static {
            static var onceToken: dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    public class func parseClassName() -> String {
        return "record"
    }
    // MARK: Properties
    public var itemName: String? {
        get {
            return self["item"] as? String
        }
        set(newValue) {
            self["item"] = newValue
        }
    }
    
    public var itemQuantity: Int? {
        get {
            return self["quantity"] as? Int
        }
        set(newValue) {
            self["quantity"] = newValue
        }
    }
    
    public var itemType: String? {
        get {
            return self["type"] as? String
        }
        set(newValue) {
            self["type"] = newValue
        }
    }
    
    public var itemDate: String? {
        get {
            return self["date"] as? String
        }
        set(newValue) {
            self["date"] = newValue
        }
    }
    
    // MARK: Helper
//    public static func itemTypeFrom(type: TRTrackingType) -> String {
//        return (type == TRTrackingType.TrackAction) ? "action" : "urge"
//    }
    
    public static func stringFromSortType(sortType: TRTrackingType) -> String {
        switch (sortType) {
        case .TrackAction:
            return "action"
        case .TrackUrge:
            return "urge"
        }
    }
    
}