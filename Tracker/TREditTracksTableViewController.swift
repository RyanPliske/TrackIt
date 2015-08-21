import UIKit
import Parse

protocol TREditTracksObserver {
    func dismissEditTracks()
}

class TREditTracksTableViewController: UITableViewController {
    var editTracksObserver: TREditTracksObserver?
    var trackerModel: TRTrackerModel
    var reuseIdentifier = "EditCell"
    
    init(_trackerModel: TRTrackerModel) {
        trackerModel = _trackerModel
        super.init(style: UITableViewStyle.Plain)
        tableView = TREditTracksTableView(frame: self.view.frame)
        tableView.registerClass(TREditTracksTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit"
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done, target: self, action: "dismissEditTracks")
    }
    
    // MARK: editTracksObserver
    
    func dismissEditTracks() {
        editTracksObserver?.dismissEditTracks()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackerModel.records.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: TREditTracksTableViewCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! TREditTracksTableViewCell
        cell.textLabel?.text = trackerModel.records[indexPath.row].objectForKey("item") as? String

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

}
