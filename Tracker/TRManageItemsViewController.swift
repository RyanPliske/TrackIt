import Foundation

class TRManageItemsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var itemsTableView: TRSettingsTableView!
    private var recordService = TRRecordService()
    private var recordsModel: TRRecordsModel
    private var numberOfItemsInRecordsModel: Int
    
    required init?(coder aDecoder: NSCoder) {
        recordsModel = TRRecordsModel(recordService: self.recordService)
        numberOfItemsInRecordsModel = recordsModel.trackableItems.allItems.count
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Items"
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addItem")
        navigationItem.rightBarButtonItem = addButton
        itemsTableView.dataSource = self
    }
    
    func addItem() {
        UIAlertView(title: "Under Construction.", message: "Not implemented yet.", delegate: self, cancelButtonTitle: "Okay!").show()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItemsInRecordsModel
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: TRSettingsTableViewCell = tableView.dequeueReusableCellWithIdentifier("items") as! TRSettingsTableViewCell
        if (indexPath.row == 0) {
            cell.topBorder.hidden = false
        } else if (indexPath.row == (numberOfItemsInRecordsModel - 1)) {
            cell.bottomBorder.hidden = false
        }
        let name: String = recordsModel.trackableItems.allItems[indexPath.row]
        cell.setSettingNameWith(name)
        return cell
    }
    
}