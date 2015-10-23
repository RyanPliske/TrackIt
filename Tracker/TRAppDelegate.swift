import UIKit
import Fabric
import Crashlytics
import Parse
import MMDrawerController

@UIApplicationMain
class TRAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        #if RELEASE
            Fabric.with([Crashlytics()])
        #endif
        Parse.enableLocalDatastore()
        Parse.setApplicationId("xXgO9EuCmM0fMAPvTk7jxPWQomcQPH40IcrKnCCf",
            clientKey: "ErKp2ZiaCImNSpiUQaCXWEAtClBou0b4qrBk7anU")
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        TRItem.registerSubclass()
        
        let centerViewController = UIStoryboard(name: "TRMain", bundle: nil).instantiateViewControllerWithIdentifier("TRTrackerViewController") as! TRTrackerViewController
        let firstNavigationController = UINavigationController(rootViewController: centerViewController)
        firstNavigationController.navigationBar.barTintColor = UIColor.blackColor()
        centerViewController._navigationController = firstNavigationController
        let rightViewController = UIStoryboard(name: "TRMain", bundle: nil).instantiateViewControllerWithIdentifier("TRSettingsViewController") as! TRSettingsViewController
        let secondNavigationController = UINavigationController(rootViewController: rightViewController)
        secondNavigationController.navigationBar.barTintColor = UIColor.blackColor()
        rightViewController._navigationController = secondNavigationController
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        let drawerController = MMDrawerController(centerViewController: firstNavigationController, rightDrawerViewController: secondNavigationController)
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView
        window?.rootViewController = drawerController
        return true
    }
}

