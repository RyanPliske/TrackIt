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
        setLabelTextWithItem(item, cell: cell)
        cell.setCellAsBadHabit(item.isAVice)
        cell.setTagsForCellWith(indexPath.section)
        cell.delegate = trackerView
        cell.backgroundColor = TRColorGenerator.colorFor(indexPath.section)
        cell.setSelectedDateOnCalendarWith(dateToTrack)
        
        let pageViewController = TRPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)

        let firstViewController = modelController.viewControllerAtIndex(0)!
        pageViewController.setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
        pageViewController.dataSource = modelController
        
        delegate?.addChildViewControllerWith(pageViewController)

        cell.setDataView(pageViewController.view)
        
//        let itemName = itemsModel.activeItems[indexPath.section].name
//        recordsModel.searchRecordsForItem(itemName) { [weak self](records, error) -> Void in
//            if let returnedRecords = records {
//                let dateDescriptions = returnedRecords.map { $0.dateDescription as String }
//                let cell = self?.trackerView.trackerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: indexPath.section)) as! TRTrackerTableViewCell
//                cell.setWhiteDotsOnDatesWith(dateDescriptions)
//            }
//        }
        return cell
    }
    
    private var modelController: TRTrackerPageViewDataSource {
        if _modelController == nil {
            _modelController = TRTrackerPageViewDataSource()
        }
        return _modelController!
    }
    
    
    private func setLabelTextWithItem(item: TRItem, cell: TRTrackerTableViewCell) {
        cell.setItemNameLabelTextWith(item.name + ":")
        recordsModel.searchRecordsForItem(item.name, dateDescription: TRDateFormatter.descriptionForDate(dateToTrack)) { (records, error) -> Void in
            if let returnedRecords = records {
                let itemCounts: [Float] = returnedRecords.map { $0.itemQuantity! }
                let itemCountSum: Float = itemCounts.reduce(0) { $0 + $1 }
                cell.setItemLabelCountWith(itemCountSum)
            }
        }
    }
}