import Foundation

class TRTrackerPresenter: NSObject, TRTrackerViewDelegate, UITableViewDataSource {
    let trackerView: TRTrackerView
    let recordsModel: TRRecordsModel
    let itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    var datetoTrack = NSDate()
    var trackingType : TRRecordType = .TrackAction

    
    init(view: TRTrackerView, model: TRRecordsModel) {
        trackerView = view
        recordsModel = model
        super.init()
        self.trackerView.delegate = self
        self.trackerView.trackerTableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsModel.activeItems.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("trackerItems") as! TRTrackerTableViewCell
        if let aCell = cell as? TRTrackerTableViewCell {
            aCell.setItemLabelTextWith(itemsModel.activeItems[indexPath.row].name)
        }
        return cell
    }
    
    
    
}
