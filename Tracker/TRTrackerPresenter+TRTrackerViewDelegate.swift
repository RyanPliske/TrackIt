import UIKit

extension TRTrackerPresenter: TRTrackerViewDelegate {
    
    func plusButtonPressedAtRow(row: Int, completion: TRCreateRecordCompletion) {
        recordsModel.createRecordUsingRow(row, quantity: 1, date: dateToTrack, withCompletion: {
            () in
            completion()
        })
    }
    
    func textFieldReturnedWithTextAtRow(row: Int, text: String, completion: TRCreateRecordCompletion) {
        if !text.isEmpty {
            let quantityFromTextField = Float(text)
            recordsModel.createRecordUsingRow(row, quantity: quantityFromTextField!, date: dateToTrack, withCompletion: {
                () in
                completion()
            })
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