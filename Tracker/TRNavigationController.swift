import UIKit

class TRNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationBar.tintColor = UIColor.TRMimosaYellow()
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir", size: 25.0)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
