import Foundation

protocol TRStatsModelDelegate: class {
    var recordedTracksForTheMonth: TRTracks { get }
    var tag: Int { get }
    var dailyGoalType: DailyGoalType { get }
    var dailyGoal: Int { get }
    var trackingDate: NSDate { get }
}

class TRStatsModel {
    
    var graphPoints: [Int] {
        var points = [Int]()
        let monthGenerator = TRMonthGenerator(trackingDate: delegate.trackingDate)
        let tracks = recordedTracksForTheMonth
        print(tracks)
        //TODO: Use actual current week
        for day in monthGenerator.week3 {
            let filter = tracks.filter { $0.dayIndex == day }
            if filter.isEmpty {
                points.append(0)
            } else {
                points.append(Int(filter.first!.count))
            }
        }
        return points
    }
    var recordedTracksForTheMonth: TRTracks {
        return delegate.recordedTracksForTheMonth
    }
    
    private weak var delegate: TRStatsModelDelegate!
    
    init(withDelegate delegate: TRStatsModelDelegate) {
        self.delegate = delegate
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
    
}