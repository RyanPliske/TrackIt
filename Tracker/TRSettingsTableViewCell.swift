import Foundation

class TRSettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var settingNameLabel: UILabel!
    let topBorder = UIView()
    let separator = UIView()
    let bottomBorder = UIView()
    let lineColor = UIColor.darkGrayColor()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectedBackgroundView = UIView(frame: self.bounds)
        backgroundColor = UIColor(red: (20.0 / 255.0),
            green: (20.0 / 255.0),
            blue: (20.0 / 255.0),
            alpha: 1.0)
        selectedBackgroundView?.backgroundColor = UIColor(red: (40.0 / 255.0),
            green: (40.0 / 255.0),
            blue: (40.0 / 255.0),
            alpha: 1.0)

        separator.backgroundColor = lineColor
        addSubview(separator)
        
        topBorder.backgroundColor = lineColor
        topBorder.hidden = true
        addSubview(topBorder)
        
        bottomBorder.backgroundColor = lineColor
        bottomBorder.hidden = true
        addSubview(bottomBorder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        separator.frame = CGRectMake(
            (self.bounds.minX + self.bounds.width / 15.0),
            (self.bounds.maxY - 0.5),
            (self.bounds.width * (13.0 / 15.0)),
            0.5)
        topBorder.frame = CGRectMake(self.bounds.minX,
            self.bounds.minY,
            self.bounds.width,
            1.0)
        bottomBorder.frame = CGRectMake(
            self.bounds.minX,
            (self.bounds.maxY - 1.0),
            self.bounds.width,
            1.0)
    }
    
    func setSettingNameWith(name: String) {
        if let nameLabel = settingNameLabel {
            nameLabel.textColor = UIColor.whiteColor()
            nameLabel.text = name
        }
    }
    
}