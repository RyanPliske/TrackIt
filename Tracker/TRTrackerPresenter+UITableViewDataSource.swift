import UIKit

extension TRTrackerPresenter: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return itemsModel.activeItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = itemsModel.activeItems[indexPath.section]
        var cell: TRTrackerTableViewCell
        if item.incrementByOne {
            cell = tableView.dequeueReusableCellWithIdentifier("itemWithPlusButton") as! TRTrackerTableViewCellWithPlusButton
        } else {
            let aCell = tableView.dequeueReusableCellWithIdentifier("itemWithTextField") as! TRTrackerTableViewCellWithTextField
            let placeHolder = item.measurementUnit == "none" ? item.name : item.measurementUnit
            aCell.setTextFieldPlaceHolder(placeHolder)
            cell = aCell
        }
        setLabelTextWithItem(item, cell: cell)
        cell.setTagsForCellWith(indexPath.section)
        cell.delegate = trackerView
        cell.backgroundColor = TRColorGenerator.colorFor(indexPath.section)
        cell.setSelectedDateOnCalendarWith(dateToTrack)
        if item.opened {
            cell.destroyStatsView()
            cell.prepareStatsView()
        } else {
            cell.destroyStatsView()
        }
        return cell
    }
    
    private func setLabelTextWithItem(item: TRItem, cell: TRTrackerTableViewCell) {
        cell.setItemNameLabelTextWith(item.name + ":")
        recordsModel.searchRecordsForItem(item.name, dateDescription: TRDateFormatter.descriptionForDate(dateToTrack)) { (records, error) -> Void in
            if let returnedRecords = records {
                let itemCounts: [Float] = returnedRecords.map { $0.itemQuantity }
                let itemCountSum: Float = itemCounts.reduce(0) { $0 + $1 }
                cell.setItemLabelCountWith(itemCountSum)
            }
        }
    }
}