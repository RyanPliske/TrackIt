import Foundation
import Parse

class TRItem: PFObject, PFSubclassing {
    
    class func parseClassName() -> String {
        return "item"
    }
    // MARK: Properties
    var name: String {
        get {
            return self["name"] as! String
        }
        set(newValue) {
            self["name"] = newValue
        }
    }
    
    var activated: Bool {
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
    
    var isAVice: Bool {
        get {
            if let status = self["vice"] as? Bool {
                return status
            }
            else {
                return false
            }
        }
        set(newValue) {
            self["vice"] = newValue
        }
    }
    
    var measurementUnit: String {
        get {
            if let measurementUnit = self["unit"] as? String {
                return measurementUnit
            } else {
                return "none"
            }
        }
        set {
            self["unit"] = newValue
        }
    }
    
    var dailyGoal: Int? {
        get {
            return self["dailyGoal"] as? Int
        }
        set {
            self["dailyGoal"] = newValue
        }
    }
    
    var incrementByOne: Bool {
        get {
            if let increment =  self["incrementByOne"] as? Bool {
                return increment
            } else {
                return true
            }
        }
        set {
            self["incrementByOne"] = newValue
        }
    }
    
    var opened: Bool {
        get {
            if let opened =  self["opened"] as? Bool {
                return opened
            } else {
                return false
            }
        }
        set {
            self["opened"] = newValue
        }
    }
    
}