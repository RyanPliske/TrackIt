import Foundation

protocol TRStatsModelDelegate: class {
    var recordedDays: TRRecordedDays { get }
    var tag: Int { get }
}

class TRStatsModel {
    
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