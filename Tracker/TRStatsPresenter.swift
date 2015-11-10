import Foundation

class TRStatsPresenter: TRStatsViewDelegate {
    
    var statsView: TRStatsView
    var statsModel: TRStatsModel
    var recordedDays: TRRecordedDays {
        return statsModel.recordedDays
    }
    
    init(withStatsView statsView: TRStatsView, withStatsModel statsModel: TRStatsModel) {
        self.statsModel = statsModel
        self.statsView = statsView
        self.statsView.delegate = self
    }
    
}