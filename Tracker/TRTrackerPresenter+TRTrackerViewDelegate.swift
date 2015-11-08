import Foundation

extension TRTrackerPresenter: TRTrackerViewDelegate {
    func plusButtonPressedAtRow(row: Int) {
        recordsModel.createRecordUsingRow(row, quantity: 1, type: TRRecordType.TrackAction, date: dateToTrack)
    }
    
    func trackUrgeSelectedForRow(row: Int) {
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
    
    func tracksForRow(row: Int) -> TRTracks {
        return TRTracks()
    }
    
    func itemSelectedAtRow(row: Int) {
        itemsModel.updateItemOpenedStatusAtIndex(row)
    }
    
    func itemAtRowIsOpened(row:Int) -> Bool {
        return itemsModel.activeItems[row].opened
    }
}