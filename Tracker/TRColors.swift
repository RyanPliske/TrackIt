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
    
    class func TRPaleRougeDark() -> UIColor {
        return UIColor(red: 200.0 / 255.0, green: 95.0 / 255.0, blue: 95.0 / 255.0, alpha: 1.0)
    }
    
    class func TREasterBoyBlue() -> UIColor {
        return UIColor(red: 118.0 / 255.0, green: 183.0 / 255.0, blue: 182.0 / 255.0, alpha: 1.0)
    }
    
    class func TREasterBoyBlueDark() -> UIColor {
        return UIColor(red: 78.0 / 255.0, green: 173.0 / 255.0, blue: 172.0 / 255.0, alpha: 1.0)
    }
    
    class func TRMimosaYellow() -> UIColor {
        return UIColor(red: 234.0 / 255.0, green: 184.0 / 255.0, blue: 46.0 / 255.0, alpha: 1.0)
    }
    
    class func TRMimosaYellowDark() -> UIColor {
        return UIColor(red: 234.0 / 255.0, green: 164.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0)
    }
    
    class func TRHamptonShortsGreen() -> UIColor {
        return UIColor(red: 159.0 / 255.0, green: 211.0 / 255.0, blue: 127 / 255.0, alpha: 1.0)
    }
    
    class func TRHamptonShortsGreenDark() -> UIColor {
        return UIColor(red: 169.0 / 255.0, green: 231.0 / 255.0, blue: 137 / 255.0, alpha: 1.0)
    }
    
    class func TRSmokeGrey() -> UIColor {
        return UIColor(red: 30 / 255.0, green: 30 / 255.0, blue: 30 / 255.0, alpha: 1.0)
    }
}

struct TRItemColors {
    static let cellColors = [UIColor.TRPaleRouge(), UIColor.TREasterBoyBlue(), UIColor.TRMimosaYellow(), UIColor.TRHamptonShortsGreen()]
    static let darkCellColors = [UIColor.TRPaleRougeDark(), UIColor.TREasterBoyBlueDark(), UIColor.TRMimosaYellowDark(), UIColor.TRHamptonShortsGreenDark()]
}