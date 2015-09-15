import Foundation

class TRManageItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TRManageItemsTableViewCellDelegate {
    
    @IBOutlet weak var itemsTableView: TRSettingsTableView!
    private var numberOfItemsInRecordsModel: Int
    private let itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    private var selectedRow: Int?
    
    required init?(coder aDecoder: NSCoder) {
        numberOfItemsInRecordsModel = TRTrackableItems.allItems.count
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
    }
    
    func addItem() {
        UIAlertView(title: "Under Construction.", message: "Not implemented yet.", delegate: self, cancelButtonTitle: "Okay!").show()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEditItemViewController" {
            if let editItemViewController = segue.destinationViewController as? TREditItemViewController {
                if let row = selectedRow {
                    editItemViewController.itemRowToPopulateWith = row
                }
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
        return numberOfItemsInRecordsModel
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: TRManageItemsTableViewCell = tableView.dequeueReusableCellWithIdentifier("items") as! TRManageItemsTableViewCell
        if (indexPath.row == 0) {
            cell.topBorder.hidden = false
        } else if (indexPath.row == (numberOfItemsInRecordsModel - 1)) {
            cell.bottomBorder.hidden = false
        }
        let name: String = TRTrackableItems.allItems[indexPath.row]
        cell.setSettingNameWith(name)
        cell.toggleSwitch.tag = indexPath.row
        cell.toggleSwitch.on = itemsModel.allItems[indexPath.row].activated
        cell.manageItemsTableViewCellDelegate = self
        return cell
    }
    
    // MARK: TRManageItemsTableViewCellDelegate
    
    func toggleSwitchChangedValueAtRow(row: Int) {
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        let cell = itemsTableView.cellForRowAtIndexPath(indexPath) as! TRManageItemsTableViewCell
        TRItemsModel.sharedInstanceOfItemsModel.updateItemsActiveStatusAtIndex(row, activeStatus: cell.toggleSwitch.on)
    }
    
}