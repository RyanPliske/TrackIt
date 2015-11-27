import Foundation

extension TRTrackerPresenter: TRTrackerViewDelegate {
    
    func plusButtonPressedAtRow(row: Int, completion: TRCreateRecordCompletion) {
        recordsModel.createRecordUsingRow(row, quantity: 1, type: TRRecordType.TrackAction, date: dateToTrack, withCompletion: {
            () in
            completion()
        })
    }
    
    func trackUrgeSelectedForRow(row: Int, completion: TRCreateRecordCompletion) {
        recordsModel.createRecordUsingRow(row, quantity: 1, type: TRRecordType.TrackUrge, date: dateToTrack, withCompletion: {
            () in
            completion()
        })
    }
    
    func textFieldReturnedWithTextAtRow(row: Int, text: String, completion: TRCreateRecordCompletion) {
        if !text.isEmpty {
            let quantityFromTextField = Float(text)
            recordsModel.createRecordUsingRow(row, quantity: quantityFromTextField!, type: TRRecordType.TrackAction, date: dateToTrack, withCompletion: {
                () in
                completion()
            })
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
    
    func recordedMonthlyTracksForRow(row: Int) -> TRTracks {
        let itemToLookUp = itemsModel.activeItems[row]
        return recordsModel.tracksForItem(itemToLookUp, forDate: dateToTrack)
    }
    
    func itemSelectedAtRow(row: Int) {
        itemsModel.updateItemOpenedStatusAtIndex(row)
    }
    
    func itemAtRowIsOpened(row:Int) -> Bool {
        return itemsModel.activeItems[row].opened
    }
}