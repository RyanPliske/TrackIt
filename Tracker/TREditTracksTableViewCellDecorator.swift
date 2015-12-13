import UIKit

class TREditTracksTableViewCellDecorator {
    
    class func decoratedCell(cell: TREditTracksTableViewCell, indexPath: NSIndexPath, recordsModel: TRRecordsModel?) -> UITableViewCell {
        if let model = recordsModel {
            let item = model.records[indexPath.row].itemName
            let count = model.records[indexPath.row].itemQuantity
            let dateDescription = model.records[indexPath.row].dateDescription
            
            switch (model.sortType) {
            case .TrackAction:
                cell.setItemLabelTextWith(item! + ":")
                if count % 1 == 0 {
                    cell.setCountLabelTextWith((Int(count).description))
                } else {
                    cell.setCountLabelTextWith(count.description)
                }
            case .TrackUrge:
                cell.setItemLabelTextWith(item!)
                cell.setCountLabelTextWith("")
            }
            cell.setDateLabelTextWith(dateDescription)
        }
        return cell
    }
    
    class func numberOfRows(recordsModel: TRRecordsModel?) -> Int {
        if let model = recordsModel {
            return model.records.count
        } else {
            return 0
        }
    }
}