import UIKit

/**
The `TrackerButton` class is designed to set NSLayout Constraints for an HTPressableButton with the ability of distinguishing two different types : 1. TrackAction 2. TrackUrge
*/
class TRTrackerButton : HTPressableButton {
    
    var trackingType : TRTrackingType
    
    init(frame: CGRect, buttonStyle: HTPressableButtonStyle, trackingType : TRTrackingType) {
        self.trackingType = trackingType
        super.init(frame: frame, buttonStyle: buttonStyle)
    }
    
    // This is required. Will implement if I ever need it.
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    The `setButtonLayout` function will set NSLayout Constraints and add it to the UIView in which you wish to have the button appear.
    
    End Result: two Buttons Half Width Side by Side
    */
    func setButtonLayout(button : TRTrackerButton, theSuperView : UIView){
        theSuperView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        var xCoordForButton, yCoordForButton, widthForButton, heightForButton : NSLayoutConstraint!
        yCoordForButton = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: theSuperView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 80)
        widthForButton = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: theSuperView, attribute: NSLayoutAttribute.Width, multiplier: 0.44, constant: 0)
        heightForButton = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: theSuperView, attribute: NSLayoutAttribute.Height, multiplier: 0.1, constant: 0)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.buttonColor = UIColor.ht_mediumColor()
        button.shadowColor = UIColor.ht_leadDarkColor()
        
        switch button.trackingType {
        case .TrackAction:
            button.setTitle("Track", forState: UIControlState.Normal)
            xCoordForButton = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: theSuperView, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: 0)
            
        case .TrackUrge:
            button.setTitle("Track Urge", forState: UIControlState.Normal)
            xCoordForButton = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: theSuperView, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1.0, constant: 0)
        }
        theSuperView.addConstraints([xCoordForButton, yCoordForButton, widthForButton, heightForButton])
    }
}