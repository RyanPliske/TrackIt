import Foundation

class TREditTracksTableViewCellDecorator: NSObject {
    
    class func decoratedCell(cell: TREditTracksTableViewCell, indexPath: NSIndexPath, trackerModel: TRTrackerModel?) -> UITableViewCell {
        if let model = trackerModel {
            let item = model.itemsManager.records[indexPath.row].itemName
            let count = model.itemsManager.records[indexPath.row].itemQuantity
            let date = model.itemsManager.records[indexPath.row].itemDate
            
            switch (model.itemsManager.itemSortType) {
            case .TrackAction:
                cell.setItemLabelTextWith(item! + ":")
                cell.setCountLabelTextWith((count?.description)!)
            case .TrackUrge:
                cell.setItemLabelTextWith(item!)
                cell.setCountLabelTextWith("")
            }
            
            cell.setDateLabelTextWith(date!)
        }
        return cell
    }
    
    class func numberOfRows(trackerModel: TRTrackerModel?) -> Int {
        if let model = trackerModel {
            return model.itemsManager.records.count
        } else {
            return 0
        }
    }
}