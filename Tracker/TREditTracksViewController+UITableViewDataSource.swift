import Foundation

extension TREditTracksViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TREditTracksTableViewCellDecorator.numberOfRows(recordsModel)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Note: reuseIdentifier is from Storyboard
        let cell: TREditTracksTableViewCell = tableView.dequeueReusableCellWithIdentifier("editTracks") as! TREditTracksTableViewCell
        return TREditTracksTableViewCellDecorator.decoratedCell(cell, indexPath: indexPath, recordsModel: recordsModel)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let recordToDelete = recordsModel.records[indexPath.row]
            recordsModel.deleteRecordAtRow(recordToDelete)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
}