import Foundation

class TREditTracksTableViewCellDecorator: NSObject {
    
    class func decoratedCell(cell: TREditTracksTableViewCell, indexPath: NSIndexPath, trackerModel: TRTrackerModel?) -> UITableViewCell {
        if let model = trackerModel {
            switch (model.itemsManager.itemSortType) {
            case .TrackAction:
                let item = model.itemsManager.tracks[indexPath.row].itemName
                cell.setItemLabelTextWith(item!)
                let count = model.itemsManager.tracks[indexPath.row].itemQuantity
                cell.setCountLabelTextWith((count?.description)!)
                let date = model.itemsManager.tracks[indexPath.row].itemDate
                cell.setDateLabelTextWith(date!)
            case .TrackUrge:
                let item = model.itemsManager.urges[indexPath.row].itemName
                cell.setItemLabelTextWith(item!)
                let count = model.itemsManager.urges[indexPath.row].itemQuantity
                cell.setCountLabelTextWith((count?.description)!)
                let date = model.itemsManager.urges[indexPath.row].itemDate
                cell.setDateLabelTextWith(date!)
            }
        }
        return cell
    }
    
    class func numberOfRows(trackerModel: TRTrackerModel?) -> Int {
        if let model = trackerModel {
            switch (model.itemsManager.itemSortType) {
                case .TrackAction:
                    return model.itemsManager.tracks.count
                case .TrackUrge:
                    return model.itemsManager.urges.count
            }
        } else {
            return 0
        }
    }
}