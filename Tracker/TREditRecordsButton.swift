import Foundation
import QuartzCore

class TREditRecordsButton: UIButton {

    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let editImage = UIImage(named: "pen-image")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
//        imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        setImage(editImage, forState: UIControlState.Normal)
        setTitle("Edit Records", forState: UIControlState.Normal)
        titleEdgeInsets = UIEdgeInsetsMake(1.0, -35.0, 1.0, 2.0)
        tintColor = UIColor.whiteColor()
        layer.cornerRadius = 3.0
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = 1.0
        titleLabel?.font = UIFont(name: "Avenir", size: 12.0)
    }
}