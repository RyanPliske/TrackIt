import Foundation

struct TRPreloadedItems {
    static var regularItems: [Int : Dictionary<String, NSObject>] = [
        0: ["name" : "Workouts", "unit" : "none", "increment" : true],
        1: ["name" : "Protein", "unit" : "grams", "increment" : false],
        2: ["name" : "Calories", "unit" : "kcal", "increment" : false]
    ]
    static var sinfulItems  = ["Drinks", "Cigarettes", "Junk Food"]
    static var allItems : [String] {
        var regular = [String]()
        for var count = 0; count < regularItems.count; count++ {
            regular.append(self.regularItems[count]!["name"]! as! String)
            count++
        }
       return self.sinfulItems + regular
    }
    static let ListOfQuantities = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
}