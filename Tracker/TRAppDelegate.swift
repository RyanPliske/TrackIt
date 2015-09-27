import UIKit
import Fabric
import Crashlytics
import Parse

@UIApplicationMain
class TRAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Fabric.with([Crashlytics()])
        Parse.enableLocalDatastore()
        Parse.setApplicationId("xXgO9EuCmM0fMAPvTk7jxPWQomcQPH40IcrKnCCf",
            clientKey: "ErKp2ZiaCImNSpiUQaCXWEAtClBou0b4qrBk7anU")
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        TRItemsModel.sharedInstanceOfItemsModel
        return true
    }
}

