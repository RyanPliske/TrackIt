import Foundation

class TRSettingsTableView: UITableView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let topBorder = UIView(frame: CGRectMake(self.bounds.minX,
            self.bounds.minY,
            self.bounds.width,
            1.0))
        topBorder.backgroundColor = UIColor.darkGrayColor()
        addSubview(topBorder)
        
        let bottomBorder = UIView(frame: CGRectMake(self.bounds.minX,
            (self.bounds.maxY - 1.0),
            self.bounds.width,
            1.0))
        bottomBorder.backgroundColor = UIColor.darkGrayColor()
        addSubview(bottomBorder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.clearColor()
    }
}