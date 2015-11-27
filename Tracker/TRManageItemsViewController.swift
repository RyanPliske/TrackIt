import Foundation

class TRManageItemsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var itemsTableView: UITableView!
    private let itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    private var itemsPresenter: TRManageItemsPresenter?
    private var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Items"
        navigationItem.rightBarButtonItem = self.editButtonItem()
        itemsPresenter = TRManageItemsPresenter(itemsModel: self.itemsModel, itemsTableView: self.itemsTableView)
        itemsTableView.dataSource = itemsPresenter
        itemsTableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        itemsTableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEditItemViewController" {
            if let editItemViewController = segue.destinationViewController as? TREditItemViewController {
                if let row = selectedRow {
                    editItemViewController.itemRowToPopulateWith = row
                }
                selectedRow = nil
            }
        }
        super.prepareForSegue(segue, sender: sender)
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if let presenter = itemsPresenter {
            presenter.editMode = editing
        }
        itemsTableView.setEditing(editing, animated: animated)
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row
        performSegueWithIdentifier("showEditItemViewController", sender: nil)
    }
    
}