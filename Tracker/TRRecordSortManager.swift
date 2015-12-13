import UIKit
import Parse

class TRRecordSortManager {
    var sortType = TRRecordType.TrackAction
    var searchMode = false
    var tracks = [TRRecord]()
    var urges = [TRRecord]()
    var searchResultsForTracks = [TRRecord]()
    var searchResultsForUrges = [TRRecord]()
    var records: [TRRecord] {
        if searchMode {
            switch (sortType) {
            case .TrackAction:
                return self.searchResultsForTracks.reverse()
            case .TrackUrge:
                return self.searchResultsForUrges.reverse()
            }
        } else {
            switch (sortType) {
            case .TrackAction:
                return self.tracks.reverse()
            case .TrackUrge:
                return self.urges.reverse()
            }
        }
    }
    
    func removeRecord(record: TRRecord) {
        
        func isNotEqual(_record: TRRecord) -> Bool {
            // Identity Operator: determines if two references both refer to the same instance
            return _record !== record
        }
        
        switch (sortType) {
        case .TrackAction:
            tracks = tracks.filter(isNotEqual)
            searchResultsForTracks = searchResultsForTracks.filter(isNotEqual)
        case .TrackUrge:
            // Compiler infers the parameter and return types of the closure
            urges = urges.filter { _record in _record !== record }
            // Shorthand argument notation
            searchResultsForUrges = searchResultsForUrges.filter { $0 !== record }
        }
    }
}