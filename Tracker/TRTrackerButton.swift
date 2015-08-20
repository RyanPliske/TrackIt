import UIKit

/**
The `TrackerButton` class is designed for two different types : 1. TrackAction 2. TrackUrge
*/
class TRTrackerButton: HTPressableButton {
    
    var trackingType: TRTrackingType
    
    init(frame: CGRect, buttonStyle: HTPressableButtonStyle, trackingType : TRTrackingType) {
        self.trackingType = trackingType
        super.init(frame: frame, buttonStyle: buttonStyle)
    }
    
    // This is required. Will implement if I ever need it.
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}