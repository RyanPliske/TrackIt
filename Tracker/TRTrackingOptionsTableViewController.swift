import Foundation

protocol TRTrackingOptionsDelegate {
    func trackUrge()
}

class TRTrackingOptionsTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    var delegate: TRTrackingOptionsDelegate?
    var associatedItemIsAVice = false
    private enum cellIndex: Int {
        case trackUrge = 0
        case trackMultiple
        static let allCellItems = [trackUrge, trackMultiple]
    }
    
    init(associatedItemIsAVice: Bool) {
        super.init(style: UITableViewStyle.Plain)
        self.associatedItemIsAVice = associatedItemIsAVice
        self.preferredContentSize = CGSizeMake(self.view.bounds.width / 2, 90)
        tableView.registerNib(UINib(nibName: "TRTrackingOptionsTableViewCellMultiple", bundle: nil), forCellReuseIdentifier: "trackMultiple")
        if associatedItemIsAVice {
            tableView.registerNib(UINib(nibName: "TRTrackingOptionsTableViewCellUrge", bundle: nil), forCellReuseIdentifier: "trackUrge")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // Data Source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if associatedItemIsAVice {
            return cellIndex.allCellItems.count
        } else {
            return cellIndex.allCellItems.count - 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == cellIndex.trackUrge.rawValue) && associatedItemIsAVice {
            return tableView.dequeueReusableCellWithIdentifier("trackUrge")!
        }
        return tableView.dequeueReusableCellWithIdentifier("trackMultiple")!
    }
    
    // Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == cellIndex.trackUrge.rawValue && associatedItemIsAVice {
            delegate?.trackUrge()
        }
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
}
