import Foundation

class TRTrackerPresenter: NSObject, TRTrackerViewDelegate, UITableViewDataSource {
    let trackerView: TRTrackerView
    let recordsModel: TRRecordsModel
    lazy var itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    var datetoTrack = NSDate()
    var trackingType : TRRecordType = .TrackAction

    
    init(view: TRTrackerView, model: TRRecordsModel) {
        trackerView = view
        recordsModel = model
        super.init()
        self.trackerView.delegate = self
        self.trackerView.trackerTableView.dataSource = self
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return itemsModel.activeItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("trackerItems") as! TRTrackerTableViewCell
        cell.setItemLabelTextWith(itemsModel.activeItems[indexPath.section].name)
        cell.setTagsForCellWith(indexPath.section)
        cell.delegate = trackerView
        cell.backgroundColor = TRTrackerTableViewCellColorGenerator.colorFor(indexPath.section)
        return cell
    }
    
    // MARK: TRTrackerViewDelegate
    
    func trackItemAt(row: Int) {
        recordsModel.createRecordUsingRow(row, quantity: 1, type: TRRecordType.TrackAction, date: datetoTrack)
    }
    
}
