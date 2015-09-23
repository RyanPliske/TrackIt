import Foundation

class TRCellColorGenerator {
    class func colorFor(row: Int) -> UIColor {
        return TRItemColors.cellColors[(row + 4) % 4]
    }
}