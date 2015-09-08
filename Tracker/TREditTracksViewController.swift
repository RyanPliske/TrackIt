import UIKit

protocol TREditTracksObserver {
    func dismissEditTracks()
}

class TREditTracksViewController: UIViewController {
    var editTracksObserver: TREditTracksObserver?
    var recordsModel: TRRecordsModel?
    @IBOutlet weak var editTracksTableView: TREditTracksTableView!
    @IBOutlet weak var itemTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var recordSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTracksTableView.dataSource = self
        recordSearchBar.delegate = self
        title = "TrackIt"
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
        super.viewWillDisappear(animated)
        recordsModel?.setSortTypeTo(TRTrackingType.TrackAction)
        view.endEditing(true)
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
            recordsModel?.setSortTypeTo(TRTrackingType.TrackAction)
            editTracksTableView.reloadData()
        } else {
            recordsModel?.setSortTypeTo(TRTrackingType.TrackUrge)
            editTracksTableView.reloadData()
        }
    }

    func dismissEditTracks() {
        editTracksObserver?.dismissEditTracks()
    }
    
}
