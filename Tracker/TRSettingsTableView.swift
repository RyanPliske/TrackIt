import Foundation

class TRSettingsTableView: UITableView {
    
    let topBorder = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clearColor()
        topBorder.backgroundColor = UIColor.darkGrayColor()
        addSubview(topBorder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topBorder.frame = CGRectMake(self.bounds.minX,
            self.bounds.minY,
            self.bounds.width,
            1.0)
    }
}