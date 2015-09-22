import Foundation

extension UIColor {
    class func TRBabyBlue() -> UIColor {
        return UIColor(red: 0.0 / 255.0, green: 147.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    class func TRAquaBlue() -> UIColor {
        return UIColor(red: 0.0, green: 147.0, blue: 255.0, alpha: 1.0)
    }
    
    class func TRPaleRouge() -> UIColor {
        return UIColor(red: 181.0 / 255.0, green: 89.0 / 255.0, blue: 90.0 / 255.0, alpha: 1.0)
    }
    
    class func TREasterBoy() -> UIColor {
        return UIColor(red: 118.0 / 255.0, green: 183.0 / 255.0, blue: 182.0 / 255.0, alpha: 1.0)
    }
    
    class func TRMimosa() -> UIColor {
        return UIColor(red: 234.0 / 255.0, green: 184.0 / 255.0, blue: 46.0 / 255.0, alpha: 1.0)
    }
    
    class func TRHamptonShorts() -> UIColor {
        return UIColor(red: 159.0 / 255.0, green: 211.0 / 255.0, blue: 127 / 255.0, alpha: 1.0)
    }
}

struct TRItemColors {
       static let cellColors = [UIColor.TRPaleRouge(), UIColor.TREasterBoy(), UIColor.TRMimosa(), UIColor.TRHamptonShorts()]
}