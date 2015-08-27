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
    
    override func viewWillDisappear(animated: Bool) {
        trackerModel?.setSortType(TRTrackingType.TrackAction)
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
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if let model = trackerModel {
                let recordToDelete = model.itemsManager.records[indexPath.row]
                model.untrack(recordToDelete)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        }
    }

}
