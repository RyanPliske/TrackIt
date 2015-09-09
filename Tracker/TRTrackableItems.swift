import Foundation

struct TRTrackableItems {
    static var regularItems = ["Workouts", "Protein", "Calories"]
    static var sinfulItems  = ["Drinks", "Cigarettes", "Junk Food"]
    static var allItems : [String] {
       return self.sinfulItems + self.regularItems
    }
    static let ListOfQuantities = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
}