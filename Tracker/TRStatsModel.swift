import Foundation

protocol TRStatsModelDelegate: class {
    var recordedTracksForTheMonth: TRTracks { get }
    var tag: Int { get }
}

class TRStatsModel {
    
    var graphPoints = [4, 2, 6, 4, 5, 8, 3]
    var recordedTracksForTheMonth: TRTracks!
    
    private weak var delegate: TRStatsModelDelegate!
    
    init(withDelegate delegate: TRStatsModelDelegate) {
        self.delegate = delegate
        getRecordedTracks()
    }
    
    var recordedDays: TRRecordedDays {
        return (days: [1,2], dailyGoalType: DailyGoalType.Max)
    }
    
    var itemIndex: Int {
        return delegate.tag
    }
    
    func getRecordedTracks() {
        self.recordedTracksForTheMonth = delegate.recordedTracksForTheMonth
    }
    
}