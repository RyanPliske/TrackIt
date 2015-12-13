import UIKit

class TRColorGenerator {
    class func colorFor(row: Int) -> UIColor {
        return TRItemColors.cellColors[(row + 4) % 4]
    }
    
    class func darkColorFor(row: Int) -> UIColor {
        return TRItemColors.darkCellColors[(row + 4) % 4]
    }
}