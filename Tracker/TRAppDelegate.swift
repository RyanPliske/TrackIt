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
        setRootViewController()
        return true
    }
    
    private func setRootViewController() {
        let centerViewController = UIStoryboard(name: "TRMain", bundle: nil).instantiateViewControllerWithIdentifier("TRTrackerViewController") as! TRTrackerViewController
        let firstNavigationController = TRNavigationController(rootViewController: centerViewController)
        let rightViewController = UIStoryboard(name: "TRMain", bundle: nil).instantiateViewControllerWithIdentifier("TRSettingsViewController") as! TRSettingsViewController
        let secondNavigationController = TRNavigationController(rootViewController: rightViewController)

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.makeKeyAndVisible()
        let drawerController = MMDrawerController(centerViewController: firstNavigationController, rightDrawerViewController: secondNavigationController)
        drawerController.openDrawerGestureModeMask = [.PanningCenterView]
        drawerController.closeDrawerGestureModeMask = [.PanningCenterView, .TapCenterView, .TapNavigationBar]
        drawerController.shouldStretchDrawer = false
        window!.rootViewController = drawerController
    }
}

