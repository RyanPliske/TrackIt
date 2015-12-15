import UIKit

class TRTrackerPresenter: TRItemsModelDelegate, TRRecordsModelDelegate, TRTrackerViewDelegate {
    let trackerView: TRTrackerView
    let recordsModel: TRRecordsModel
    let itemsModel: TRItemsModel

    init(view: TRTrackerView, recordsModel: TRRecordsModel, itemsModel: TRItemsModel) {
        trackerView = view
        self.recordsModel = recordsModel
        self.itemsModel = itemsModel
        self.recordsModel.delegate = self
        self.trackerView.delegate = self
    }
    
    //MARK: - TRItemsModelDelegate
    
    func itemOpenedStatusChangedAtIndex(index: Int) {
        trackerView.itemOpenedStatusChangedAtIndex(index)
    }
    
    func itemTrackByOneStatusChangedAtIndex(index: Int) {
        trackerView.trackerTableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: index)], withRowAnimation: .None)
    }
    
    //MARK: - TRRecordsModelDelegate
    
    func recordsChangedWithName(name: String) {
        let filter = itemsModel.activeItems.filter { $0.name == name }.first!
        let index = itemsModel.activeItems.indexOf(filter)!
        trackerView.trackerTableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: index)], withRowAnimation: .None)
    }
    
    //MARK: TRTrackerViewDelegate
    
    func plusButtonPressedAtRow(row: Int, completion: TRCreateRecordCompletion) {
//        recordsModel.createRecordUsingRow(row, quantity: 1, date: dateToTrack, withCompletion: {
//            () in
//            completion()
//        })
    }
    
    func textFieldReturnedWithTextAtRow(row: Int, text: String, completion: TRCreateRecordCompletion) {
//        if !text.isEmpty {
//            let quantityFromTextField = Float(text)
//            recordsModel.createRecordUsingRow(row, quantity: quantityFromTextField!, date: dateToTrack, withCompletion: {
//                () in
//                completion()
//            })
//        }
    }
    
    func recordedMonthlyTracksForRow(row: Int) -> TRTracks {
        let itemToLookUp = itemsModel.activeItems[row]
        return recordsModel.tracksForItem(itemToLookUp)
    }
    
    func itemSelectedAtRow(row: Int) {
//        itemsModel.updateItemOpenedStatusAtIndex(row)
    }
    
    func itemAtRowIsOpened(row:Int) -> Bool {
//        return itemsModel.activeItems[row].opened
        return true
    }
    
}
