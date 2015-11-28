import Foundation

class TRManageItemsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var itemsTableView: UITableView!
    private let itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    private var itemsPresenter: TRManageItemsPresenter?
    private var selectedRow: Int?
    private var snapshot: UIView?
    private var sourceIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Items"
        navigationItem.rightBarButtonItem = self.editButtonItem()
        itemsPresenter = TRManageItemsPresenter(itemsModel: self.itemsModel, itemsTableView: self.itemsTableView)
        itemsTableView.dataSource = itemsPresenter
        itemsTableView.delegate = self
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPressRecognized:")
        itemsTableView.addGestureRecognizer(longPress)
    }
    
    override func viewWillAppear(animated: Bool) {
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
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if let presenter = itemsPresenter {
            presenter.editMode = editing
        }
        itemsTableView.setEditing(editing, animated: animated)
    }
    
    func longPressRecognized(longPress: UILongPressGestureRecognizer) {
        if itemsPresenter!.editMode == false {
            return
        }
        let location = longPress.locationInView(itemsTableView)
        let indexPath = itemsTableView.indexPathForRowAtPoint(location)
        
        switch(longPress.state) {
        case .Began:
            guard let path = indexPath else {
                break
            }
            sourceIndexPath = path
            let cell = itemsTableView.cellForRowAtIndexPath(path)!
            snapshot = customSnapshotFromView(cell)
            var center = cell.center
            snapshot!.center = center
            snapshot!.alpha = 0.0
            itemsTableView.addSubview(snapshot!)
            UIView.animateWithDuration(0.25, animations: { [weak self]() -> Void in
                center.y = location.y
                self?.snapshot!.center = center
                self?.snapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05)
                self?.snapshot!.alpha = 0.98
                
                cell.alpha = 0.0
                }, completion: { (completed) -> Void in
                    cell.hidden = true
            })
            break
            
        case .Changed:
            if var center = snapshot?.center {
                center.y = location.y
                snapshot?.center = center
                if let path = indexPath where !path.isEqual(sourceIndexPath) {
                    TRItemsModel.sharedInstanceOfItemsModel.exchangeItemAtIndex(sourceIndexPath!.row, withItemAtIndex: path.row)
                    itemsTableView.moveRowAtIndexPath(sourceIndexPath!, toIndexPath: path)
                    sourceIndexPath = indexPath
                }
            }
            
            break
            
        default:
            if let path = sourceIndexPath, let cell = itemsTableView.cellForRowAtIndexPath(path) {
                cell.hidden = false
                cell.alpha = 0.0
                UIView.animateWithDuration(0.25, animations: { [weak self]() -> Void in
                    self?.snapshot?.center = cell.center
                    self?.snapshot?.transform = CGAffineTransformIdentity
                    self?.snapshot?.alpha = 0.0
                    
                    cell.alpha = 1.0
                    }, completion: { [weak self](completed) -> Void in
                        self?.sourceIndexPath = nil
                        self?.snapshot?.removeFromSuperview()
                        self?.snapshot = nil
                        self?.itemsTableView.reloadData()
                    })
            }
            break
        }
        
    }
    
    private func customSnapshotFromView(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let snapshot = UIImageView(image: image)
        snapshot.layer.masksToBounds = false
        snapshot.layer.cornerRadius = 0.0
        snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        snapshot.layer.shadowRadius = 5.0
        snapshot.layer.shadowOpacity = 0.4
        return snapshot
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row
        performSegueWithIdentifier("showEditItemViewController", sender: nil)
    }
    
}