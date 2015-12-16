import UIKit

class TRSettingsViewController: UIViewController, UITableViewDelegate {
    
    var recordsModel: TRRecordsModel!
    var itemsModel: TRItemsModel!
    var settingsPresenter: TRSettingsPresenter?
    @IBOutlet weak var settingsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        settingsPresenter = TRSettingsPresenter(settingsView: settingsTableView)
        settingsTableView.dataSource = self.settingsPresenter
        settingsTableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        settingsTableView.deselectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false)
        settingsTableView.deselectRowAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), animated: false)
        settingsTableView.deselectRowAtIndexPath(NSIndexPath(forItem: 2, inSection: 0), animated: false)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            self.performSegueWithIdentifier("showManageItems", sender: self)
        } else if indexPath.row == 1 {
            self.performSegueWithIdentifier("showEditItemFromSettings", sender: self)
        } else if indexPath.row == 2 {
//            self.performSegueWithIdentifier("showEditTracks", sender: self)
        }
    }
    
    //TODO: Pass the needed models to the appropriate View Controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let editTracksVC = segue.destinationViewController as? TREditTracksViewController {
            editTracksVC.itemsModel = itemsModel
            editTracksVC.recordsModel = recordsModel
        } else if let editItemVC = segue.destinationViewController as? TREditItemViewController {
            editItemVC.itemsModel = itemsModel
        }
    }

}
