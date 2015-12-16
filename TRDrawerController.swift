import UIKit
import MMDrawerController

class TRDrawerController: MMDrawerController {
    
    private var recordsModel: TRRecordsModel!
    private var itemsModel: TRItemsModel!
    
    init() {
        itemsModel = TRItemsModel(itemService: TRItemService())
        recordsModel = TRRecordsModel(recordService: TRRecordService(), itemsModel: itemsModel)
        
        let centerViewController = UIStoryboard(name: "TRMain", bundle: nil).instantiateViewControllerWithIdentifier("TRTrackerViewController") as! TRTrackerViewController
        centerViewController.recordsModel = recordsModel
        centerViewController.itemsModel = itemsModel
        let firstNavigationController = TRNavigationController(rootViewController: centerViewController)
        
        let rightViewController = UIStoryboard(name: "TRMain", bundle: nil).instantiateViewControllerWithIdentifier("TRSettingsViewController") as! TRSettingsViewController
        rightViewController.recordsModel = recordsModel
        rightViewController.itemsModel = itemsModel
        let secondNavigationController = TRNavigationController(rootViewController: rightViewController)
        
        super.init(centerViewController: firstNavigationController, leftDrawerViewController: nil, rightDrawerViewController: secondNavigationController)
        self.openDrawerGestureModeMask = [.PanningCenterView]
        self.closeDrawerGestureModeMask = [.PanningCenterView, .TapCenterView, .TapNavigationBar]
        self.shouldStretchDrawer = false
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // Won't be utilizing this, I want the app to crash if this gets used
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}