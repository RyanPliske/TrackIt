import UIKit

protocol TREditTracksObserver {
    func dismissEditTracks()
}

class TREditTracksViewController: UIViewController, UITableViewDataSource {
    var editTracksObserver: TREditTracksObserver?
    var trackerModel: TRTrackerModel?
    @IBOutlet weak var editTracksTableView: TREditTracksTableView!
    @IBOutlet weak var itemTypeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTracksTableView.dataSource = self
        title = "Edit"
        navigationItem.rightBarButtonItem = self.editButtonItem()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done, target: self, action: "dismissEditTracks")
    }
    
    // MARK: editTracksObserver
    
    func dismissEditTracks() {
        editTracksObserver?.dismissEditTracks()
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackerModel!.records.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Note: reuseIdentifier is from Storyboard
        let cell: TREditTracksTableViewCell = tableView.dequeueReusableCellWithIdentifier("editTracks") as! TREditTracksTableViewCell
        if let model = trackerModel {
            let item = model.records[indexPath.row].itemName
            cell.setItemLabelTextWith(item!)
            let count = model.records[indexPath.row].itemQuantity
            cell.setCountLabelTextWith((count?.description)!)
            let date = model.records[indexPath.row].itemDate
            cell.setDateLabelTextWith(date!)
        }
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.editTracksTableView.setEditing(editing, animated: animated)
    }
}
