import Foundation

protocol TRStatsModelDelegate: class {
    var recordedDays: TRRecordedDays { get }
    var tag: Int { get }
}

class TRStatsModel {
    
    var graphPoints = [4, 2, 6, 4, 5, 8, 3]
    
    private weak var delegate: TRStatsModelDelegate!
    
    init(withDelegate delegate: TRStatsModelDelegate) {
        self.delegate = delegate
    }
    
    var recordedDays: TRRecordedDays {
        return delegate.recordedDays
    }
    
    var itemIndex: Int {
        return delegate.tag
    }
    
}