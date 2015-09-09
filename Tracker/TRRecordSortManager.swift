import Foundation
import Parse

class TRRecordSortManager : NSObject {
    var trackableItems = TRTrackableItems()
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
                return self.searchResultsForTracks
            case .TrackUrge:
                return self.searchResultsForUrges
            }
        } else {
            switch (sortType) {
            case .TrackAction:
                return self.tracks
            case .TrackUrge:
                return self.urges
            }
        }
    }
    
    func removeRecord(record: TRRecord) {
        switch (sortType) {
        case .TrackAction:
            tracks = tracks.filter { $0 !== record }
            searchResultsForTracks = searchResultsForTracks.filter { $0 !== record }
        case .TrackUrge:
            urges = urges.filter { $0 !== record }
            searchResultsForUrges = searchResultsForUrges.filter { $0 !== record }
        }
    }
}