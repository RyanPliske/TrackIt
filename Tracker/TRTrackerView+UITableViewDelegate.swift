import Foundation

extension TRTrackerView: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.sizeToFit()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if delegate!.itemAtRowIsOpened(indexPath.section) {
            return TRTrackerTableViewCellSize.openedHeight
        }
        return TRTrackerTableViewCellSize.closedHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.itemSelectedAtRow(indexPath.section)
    }
}