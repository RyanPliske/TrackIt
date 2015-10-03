import Foundation

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
        setLabelTextAtSection(item, cell: cell)
        cell.setCellAsBadHabit(item.isAVice)
        cell.setTagsForCellWith(indexPath.section)
        cell.delegate = trackerView
        cell.backgroundColor = TRColorGenerator.colorFor(indexPath.section)
        cell.setSelectedDateOnCalendarWith(dateToTrack)
        return cell
    }
    
    private func setLabelTextAtSection(item: TRItem, cell: TRTrackerTableViewCell) {
        recordsModel.searchRecordsForItem(item.name, dateDescription: TRDateFormatter.descriptionForDate(dateToTrack)) { (records, error) -> Void in
            if let returnedRecords = records {
                let itemCounts: [Float] = returnedRecords.map { $0.itemQuantity! }
                let itemCountSum: Float = itemCounts.reduce(0) { $0 + $1 }
                cell.setItemLabelTextWith(item.name, itemCount: itemCountSum)
            } else {
                cell.setItemLabelTextWith(item.name, itemCount: nil)
            }
        }
    }
}