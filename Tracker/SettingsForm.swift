import UIKit

class SettingsForm: NSObject, FXForm {
    var itemName: String?
    // var password: String?
    // var repeatPassword: String?
    
    func itemNameField()->NSDictionary{
        return ["contentView.backgroundColor" : UIColor.darkGrayColor(),
            "textLabel.color" : UIColor.whiteColor() ]
    }
    /*
    func passwordField()->NSDictionary{
        return ["contentView.backgroundColor" : UIColor.darkGrayColor(),
            "textLabel.color" : UIColor.whiteColor() ]
    }
    
    func repeatPasswordField()->NSDictionary{
        return ["contentView.backgroundColor" : UIColor.darkGrayColor(),
            "textLabel.color" : UIColor.whiteColor() ]
    }
    */
}
