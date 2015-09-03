import Foundation

class TRManageItemsViewController: UIViewController {
    
    @IBOutlet weak var itemsTableView: TRSettingsTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Items"
        itemsTableView.dataSource = self
    }
    
}