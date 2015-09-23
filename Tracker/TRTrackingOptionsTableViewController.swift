import Foundation

protocol TRTrackingOptionsDelegate {
    func trackUrge()
}

class TRTrackingOptionsTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    var delegate: TRTrackingOptionsDelegate?
    private enum cellIndex: Int {
        case trackUrge = 0
        case trackMultiple
        static let allCellItems = [trackUrge, trackMultiple]
    }
    
    init() {
        super.init(style: UITableViewStyle.Plain)
        tableView.registerNib(UINib(nibName: "TRTrackingOptionsTableViewCellUrge", bundle: nil), forCellReuseIdentifier: "trackUrge")
        tableView.registerNib(UINib(nibName: "TRTrackingOptionsTableViewCellMultiple", bundle: nil), forCellReuseIdentifier: "trackMultiple")
        self.preferredContentSize = CGSizeMake(self.view.bounds.width / 2, 90)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Data Source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellIndex.allCellItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == cellIndex.trackUrge.rawValue {
            return tableView.dequeueReusableCellWithIdentifier("trackUrge")!
        }
        return tableView.dequeueReusableCellWithIdentifier("trackMultiple")!
    }
    
    // Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == cellIndex.trackUrge.rawValue {
            delegate?.trackUrge()
        }
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
}
