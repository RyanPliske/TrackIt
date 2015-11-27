import Foundation
import Parse
import Crashlytics

typealias TRReadAllItemsCompletion = ([TRItem]) -> Void

class TRItemService {
    
    private var itemsToSave = [TRItem]()
    
    func addItemToSaveWithItemName(name: String, measureUnit: String?) {
        let item = TRItem(className: "item")
        item.activated = true
        item.name = name
        if let unit = measureUnit {
            item.measurementUnit = unit
        }
        itemsToSave.append(item)
    }
    
    func addItemToSaveWithItemName(name: String, measureUnit: String?, incrementByOne: Bool) {
        let item = TRItem(className: "item")
        item.activated = true
        item.name = name
        item.incrementByOne = incrementByOne
        if let unit = measureUnit {
            item.measurementUnit = unit
        }
        itemsToSave.append(item)
    }
    
    func saveItems(completion: PFBooleanResultBlock?) {
        if let completionBlock = completion {
            TRItem.pinAllInBackground(itemsToSave, block: completionBlock)
            itemsToSave.removeAll()
        }
    }
    
    func readAllItemsFromPhone(completion: TRReadAllItemsCompletion?) {
        let BackgroundRetrievalCompletion: PFQueryArrayResultBlock = {
            (objects: [PFObject]?, error: NSError?) in
            if error != nil {
                Crashlytics()
                CLSLogv("Reading Items from phone failed with error: %@", getVaList([error!.description]))
                NSLog("Reading Items from phone failed with error: %@", error!.description)
            } else {
                // Force a crash if this fails.
                let items = objects as! [TRItem]
                if let completionBlock = completion {
                    completionBlock(items)
                }
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
    
    func updateItem(item: TRItem, incrementByOne: Bool) {
        item.incrementByOne = incrementByOne
        item.pinInBackgroundWithBlock(nil)
    }
    
    func updateItem(item: TRItem, name: String) {
        item.name = name
        item.pinInBackgroundWithBlock(nil)
    }
    
    func updateItem(item: TRItem, unit: String?) {
        if let aUnit = unit {
            item.measurementUnit = aUnit
        } else {
            item["unit"] = NSNull()
        }
        item.pinInBackgroundWithBlock(nil)
    }
    
    func updateItem(item: TRItem, goal: Int?) {
        if let aGoal = goal {
            item.dailyGoal = aGoal
        } else {
           item["dailyGoal"] = NSNull()
        }
        item.pinInBackgroundWithBlock(nil)
    }
    
    func updateItem(item: TRItem, dailyGoalType: DailyGoalType) {
        item.dailyGoalType = dailyGoalType
        item.pinInBackgroundWithBlock(nil)
    }
    
    func deleteItemFromPhone(item: TRItem, completion: PFBooleanResultBlock) {
        item.unpinInBackgroundWithBlock(completion)
    }
    
    func deleteAllItemsFromPhone() {
        do {
            try TRItem.unpinAllObjects()
        } catch {
            
        }
    }
    
}