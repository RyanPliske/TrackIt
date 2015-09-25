import Foundation

extension TREditTracksViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        if let searchText = searchBar.text {
            weak var weakSelf = self
            recordsModel.searchRecordsFor(searchText, completion: { () -> Void in
                weakSelf?.editTracksTableView.reloadData()
            })
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = nil
        recordsModel.searchMode = false
        editTracksTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

}