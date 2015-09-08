import Foundation

class TREditTracksTableViewCellDecorator: NSObject {
    
    class func decoratedCell(cell: TREditTracksTableViewCell, indexPath: NSIndexPath, trackerModel: TRRecordsModel?) -> UITableViewCell {
        if let model = trackerModel {
            let item = model.records[indexPath.row].itemName
            let count = model.records[indexPath.row].itemQuantity
            let date = model.records[indexPath.row].itemDate
            
            switch (model.sortType) {
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
    
    class func numberOfRows(trackerModel: TRRecordsModel?) -> Int {
        if let model = trackerModel {
            return model.records.count
        } else {
            return 0
        }
    }
}