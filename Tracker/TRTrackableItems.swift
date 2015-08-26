import Foundation

public struct TRTrackableItems {
    var regularItems = ["Workouts", "Protein", "Baby Kicks"]
    var sinfulItems  = ["Drinks", "Cigarettes", "Money"]
    var allItems : [String] {
       return self.sinfulItems + self.regularItems
    }
    let ListOfQuantities = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
}