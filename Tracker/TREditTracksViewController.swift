import UIKit

class TREditTracksViewController: UIViewController {

    var recordsModel: TRRecordsModel!
    var itemsModel: TRItemsModel!
    
    @IBOutlet weak var editTracksTableView: TREditTracksTableView!
    @IBOutlet weak var itemTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var recordSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordSearchBar.delegate = self
        recordSearchBar.keyboardAppearance = UIKeyboardAppearance.Dark
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        editTracksTableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        recordSearchBar.resignFirstResponder()
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

        } else {

        }
    }
    
}
