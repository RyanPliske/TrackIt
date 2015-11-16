import Foundation
import MMDrawerController

class TRDrawerController: MMDrawerController {
    
    required init?(coder aDecoder: NSCoder) {
        let centerViewController = UIStoryboard(name: "TRMain", bundle: nil).instantiateViewControllerWithIdentifier("TRTrackerViewController")
        let rightViewController = UIStoryboard(name: "TRMain", bundle: nil).instantiateViewControllerWithIdentifier("TRSettingsViewController")
        super.init(centerViewController: centerViewController, rightDrawerViewController: rightViewController)
//        super.init(coder: aDecoder)
    }
}