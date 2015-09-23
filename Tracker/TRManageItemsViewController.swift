import Foundation

class TRManageItemsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var itemsTableView: UITableView!
    private let itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    private var itemsPresenter: TRManageItemsPresenter?
    private var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Items"
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addItem")
        navigationItem.rightBarButtonItem = addButton
        itemsPresenter = TRManageItemsPresenter(itemsModel: self.itemsModel, itemsTableView: self.itemsTableView)
        itemsTableView.dataSource = itemsPresenter
        itemsTableView.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTable", name: "newItem", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        itemsTableView.reloadData()
    }
    
    func addItem() {
        performSegueWithIdentifier("showEditItemViewController", sender: nil)
    }
    
    func reloadTable() {
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
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row
        performSegueWithIdentifier("showEditItemViewController", sender: nil)
    }
    
}