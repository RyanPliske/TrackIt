import Foundation

struct TRTrackableItems {
    var regularItems = ["Workouts", "Protein", "Calories"]
    var sinfulItems  = ["Drinks", "Cigarettes", "Ate Junk Food"]
    var allItems : [String] {
       return self.sinfulItems + self.regularItems
    }
    let ListOfQuantities = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
}