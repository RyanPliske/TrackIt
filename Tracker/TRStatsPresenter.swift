import Foundation

class TRStatsPresenter: TRStatsViewDelegate {
    
    var statsView: TRStatsView!
    var statsModel: TRStatsModel
    
    init(withStatsModel statsModel: TRStatsModel) {
        self.statsModel = statsModel
    }
    
    var recordedDays: TRRecordedDays {
        return statsModel.recordedDays
    }
    
    var itemIndex: Int {
        return statsModel.itemIndex
    }
    
}