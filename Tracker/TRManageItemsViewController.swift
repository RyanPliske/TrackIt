import Foundation

class TRManageItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TRManageItemsTableViewCellDelegate {
    
    @IBOutlet weak var itemsTableView: TRSettingsTableView!
    private let itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    private var selectedRow: Int?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Items"
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addItem")
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.tintColor = UIColor.TRBabyBlue()
        itemsTableView.dataSource = self
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
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsModel.allItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: TRManageItemsTableViewCell = tableView.dequeueReusableCellWithIdentifier("items") as! TRManageItemsTableViewCell
        if (indexPath.row == 0) {
            cell.topBorder.hidden = false
            cell.bottomBorder.hidden = true
        } else if (indexPath.row == (itemsModel.allItems.count - 1)) {
            cell.topBorder.hidden = true
            cell.bottomBorder.hidden = false
        } else {
            cell.topBorder.hidden = true
            cell.bottomBorder.hidden = true
        }
        let name: String = itemsModel.allItems[indexPath.row].name
        cell.setSettingNameWith(name)
        cell.toggleSwitch.tag = indexPath.row
        cell.toggleSwitch.on = itemsModel.allItems[indexPath.row].activated
        cell.manageItemsTableViewCellDelegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row <= TRTrackableItems.allItems.count {
            return false
        } else {
            return true
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            itemsModel.deleteItemAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: TRManageItemsTableViewCellDelegate
    
    func toggleSwitchChangedValueAtRow(row: Int) {
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        let cell = itemsTableView.cellForRowAtIndexPath(indexPath) as! TRManageItemsTableViewCell
            itemsModel.updateItemsActiveStatusAtIndex(row, activeStatus: cell.toggleSwitch.on)
    }
    
}