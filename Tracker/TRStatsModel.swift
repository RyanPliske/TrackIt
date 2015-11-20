import Foundation

protocol TRStatsModelDelegate: class {
    var recordedTracksForTheMonth: TRTracks { get }
    var tag: Int { get }
    var dailyGoalType: DailyGoalType { get }
    var dailyGoal: Int { get }
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
        
        let goalType = delegate.dailyGoalType
        let goal = delegate.dailyGoal
        
        var failureDays = [Int]()
        var successDays = [Int]()
        switch (goalType) {
        case .Max:
            for track in recordedTracksForTheMonth {
                if Int(track.count) > goal {
                    failureDays.append(track.dayIndex)
                } else {
                    successDays.append(track.dayIndex)
                }
            }
        case .Min:
            for track in recordedTracksForTheMonth {
                if Int(track.count) < goal {
                    failureDays.append(track.dayIndex)
                } else {
                    successDays.append(track.dayIndex)
                }
            }
        }
        if goalType == DailyGoalType.Max {
            return (failureDays, goalType)
        } else {
            return (successDays, goalType)
        }
    }
    
    var itemIndex: Int {
        return delegate.tag
    }
    
    func getRecordedTracks() {
        recordedTracksForTheMonth = delegate.recordedTracksForTheMonth
    }
    
}