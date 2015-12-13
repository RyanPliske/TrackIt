import UIKit
import Parse

class TRRecordSortManager {
    var searchMode = false
    var tracks = [TRRecord]()

    var searchResultsForTracks = [TRRecord]()

    var records: [TRRecord] {
        if searchMode {
            return self.searchResultsForTracks.reverse()
        } else {
            return self.tracks.reverse()
        }
    }
    
    func removeRecord(record: TRRecord) {
        
        func isNotEqual(_record: TRRecord) -> Bool {
            // Identity Operator: determines if two references both refer to the same instance
            return _record !== record
        }
        tracks = tracks.filter(isNotEqual)
        searchResultsForTracks = searchResultsForTracks.filter(isNotEqual)
    }
}