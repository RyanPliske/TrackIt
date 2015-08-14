import Foundation

struct TRTrackableItems {
    
    var regularItems = ["Workouts", "Protein", "Baby Kicks"]
    var sinfulItems  = ["Drinks", "Cigarettes", "Money"]
    let ListOfQuantities = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Custom"]
    
    func getCountOfAllItems() -> Int {
        return regularItems.count + sinfulItems.count
    }
}