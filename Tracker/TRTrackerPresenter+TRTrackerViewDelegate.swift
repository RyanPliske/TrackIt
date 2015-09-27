import Foundation

extension TRTrackerPresenter: TRTrackerViewDelegate {
    func trackItemAtRow(row: Int) {
        recordsModel.createRecordUsingRow(row, quantity: 1, type: TRRecordType.TrackAction, date: dateToTrack)
    }
    
    func trackUrgeAtRow(row: Int) {
        recordsModel.createRecordUsingRow(row, quantity: 1, type: TRRecordType.TrackUrge, date: dateToTrack)
    }
    
    func textFieldReturnedWithTextAtRow(row: Int, text: String) {
        if !text.isEmpty {
            let quantityFromTextField = Float(text)
            recordsModel.createRecordUsingRow(row, quantity: quantityFromTextField!, type: TRRecordType.TrackAction, date: dateToTrack)
        }
    }
    
    func trackMultipleSelectedForRow(row: Int) {
        itemsModel.updateItemIncrementalStatusAtIndex(row)
        if itemsModel.activeItems[row].incrementByOne {
            trackerView.trackerTableView.reloadSections(NSIndexSet(index: row), withRowAnimation: UITableViewRowAnimation.Left)
        } else {
            trackerView.trackerTableView.reloadSections(NSIndexSet(index: row), withRowAnimation: UITableViewRowAnimation.Right)
        }
    }
    
    func itemSelectedAtRow(row: Int) {
        let itemName = itemsModel.activeItems[row].name
        weak var weakSelf = self
        recordsModel.searchRecordsForItem(itemName) { (objects, error) -> Void in
            if let records = objects as? [TRRecord] {
                let dates = records.map { $0.dateDescription as String }
                let cell = weakSelf?.trackerView.trackerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: row)) as! TRTrackerTableViewCell
                print(dates)
                cell.setWhiteDotsOnDatesWith(dates)

            }
        }
    }
}