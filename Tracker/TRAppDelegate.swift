import UIKit
#if RELEASE
import Fabric
import Crashlytics
#endif
import Parse

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
        
        return true
    }
}
