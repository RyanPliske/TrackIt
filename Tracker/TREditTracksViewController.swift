import UIKit

protocol TREditTracksObserver {
    func dismissEditTracks()
}

class TREditTracksViewController: UIViewController, UITableViewDataSource {
    var editTracksObserver: TREditTracksObserver?
    var trackerModel: TRTrackerModel?
    @IBOutlet weak var editTracksTableView: TREditTracksTableView!
    @IBOutlet weak var itemTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var recordSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTracksTableView.dataSource = self
        title = "Tracker"
        navigationItem.rightBarButtonItem = self.editButtonItem()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done, target: self, action: "dismissEditTracks")
        if let navController = navigationController {
            navController.navigationBar.barStyle = UIBarStyle.BlackTranslucent
            navController.navigationBar.barTintColor = UIColor.clearColor()
            let navBarHairLineImageView = findHairLineImageViewUnder(navController.navigationBar)
            navBarHairLineImageView?.hidden = true
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        editTracksTableView.setEditing(editing, animated: animated)
    }
    
    func findHairLineImageViewUnder(view: UIView) -> UIImageView? {
        if ((view.isKindOfClass(UIImageView.self)) && (view.bounds.size.height <= 1.0)) {
            return view as? UIImageView
        }
        for subview in view.subviews {
            let imageView = findHairLineImageViewUnder(subview)
            if (imageView != nil) {
                return imageView
            }
        }
        return nil
    }
    
    @IBAction func segmentControlPressed(sender: AnyObject) {
        if (itemTypeSegmentedControl.selectedSegmentIndex == 0) {
            trackerModel?.setSortType(TRTrackingType.TrackAction)
            editTracksTableView.reloadData()
        } else {
            trackerModel?.setSortType(TRTrackingType.TrackUrge)
            editTracksTableView.reloadData()
        }
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
        return TREditTracksTableViewCellDecorator.numberOfRows(trackerModel)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Note: reuseIdentifier is from Storyboard
        let cell: TREditTracksTableViewCell = tableView.dequeueReusableCellWithIdentifier("editTracks") as! TREditTracksTableViewCell
        return TREditTracksTableViewCellDecorator.decoratedCell(cell, indexPath: indexPath, trackerModel: trackerModel)
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
