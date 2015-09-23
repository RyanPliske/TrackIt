import Foundation

class TRTrackingOptionsTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
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
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCellWithIdentifier("trackUrge")!
        } else {
            return tableView.dequeueReusableCellWithIdentifier("trackMultiple")!
        }
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
}
