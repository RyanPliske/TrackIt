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
        self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.setImage(editImage, forState: UIControlState.Normal)
        self.imageEdgeInsets = UIEdgeInsetsMake(20.0, -15.0, 20.0, 0.0)
        self.setTitle("Edit Records", forState: UIControlState.Normal)
        self.titleEdgeInsets = UIEdgeInsetsMake(1.0, -35.0, 1.0, 2.0)
        self.tintColor = UIColor.whiteColor()
        self.layer.cornerRadius = 3.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1.0
        self.titleLabel?.font = UIFont(name: "Avenir", size: 13.0)
    }
}