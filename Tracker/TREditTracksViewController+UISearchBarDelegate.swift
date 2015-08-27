import Foundation

extension TREditTracksViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        if let searchText = searchBar.text {
            weak var weakSelf = self
            trackerModel?.searchRecordsFor(searchText, completion: { () -> Void in
                weakSelf?.editTracksTableView.reloadData()
            })
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = nil
        trackerModel?.setSearchModeTo(false)
        editTracksTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

}