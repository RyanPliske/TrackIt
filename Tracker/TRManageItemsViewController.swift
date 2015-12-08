import Foundation

class TRManageItemsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var itemsTableView: UITableView!
    private let itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    private var itemsPresenter: TRManageItemsPresenter?
    private var selectedRow: Int?
    private var editButton: UIBarButtonItem {
        if itemsPresenter!.editMode == false {
            return UIBarButtonItem(title: "Manage", style: .Plain, target: self, action: "edit")
        } else {
            return UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "done")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Items"
        itemsPresenter = TRManageItemsPresenter(itemsModel: self.itemsModel, itemsTableView: self.itemsTableView)
        itemsTableView.dataSource = itemsPresenter
        itemsTableView.delegate = self
        navigationItem.rightBarButtonItem = editButton
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
        itemsPresenter?.editMode = editing
        itemsTableView.setEditing(editing, animated: animated)
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc private func edit() {
        self.setEditing(true, animated: true)
    }
    
    @objc private func done() {
        self.setEditing(false, animated: true)
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row
        performSegueWithIdentifier("showEditItemViewController", sender: nil)
    }
}