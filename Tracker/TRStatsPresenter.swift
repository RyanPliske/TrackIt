import Foundation

class TRStatsPresenter: TRStatsViewDelegate {
    
    var statsView: TRStatsView
    var statsModel: TRStatsModel
    
    init(withStatsView statsView: TRStatsView, withStatsModel statsModel: TRStatsModel) {
        self.statsModel = statsModel
        self.statsView = statsView
        self.statsView.delegate = self
    }
    
    var recordedDays: TRRecordedDays {
        return statsModel.recordedDays
    }
    
}