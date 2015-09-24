import UIKit

class TREditTracksViewController: UIViewController {
    lazy var recordsModel = TRRecordsModel.sharedInstanceOfRecordsModel
    lazy var itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    @IBOutlet weak var editTracksTableView: TREditTracksTableView!
    @IBOutlet weak var itemTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var recordSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordSearchBar.delegate = self
        editTracksTableView.dataSource = self
        editTracksTableView.delegate = editTracksTableView
        title = "Tracks"
        navigationItem.rightBarButtonItem = self.editButtonItem()
        if let navController = navigationController {
            navController.navigationBar.barStyle = UIBarStyle.BlackTranslucent
            navController.navigationBar.barTintColor = UIColor.clearColor()
            let navBarHairLineImageView = findHairLineImageViewUnder(navController.navigationBar)
            navBarHairLineImageView?.hidden = true
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        recordsModel.sortType = TRRecordType.TrackAction
        view.endEditing(true)
        super.viewWillDisappear(animated)
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
            recordsModel.sortType = TRRecordType.TrackAction
            editTracksTableView.reloadData()
        } else {
            recordsModel.sortType = TRRecordType.TrackUrge
            editTracksTableView.reloadData()
        }
    }
    
}
