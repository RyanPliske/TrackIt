import Foundation

class TRSettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var settingNameLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectedBackgroundView = UIView(frame: self.bounds)
        selectedBackgroundView?.backgroundColor = UIColor(red: (20.0 / 255.0),
            green: (20.0 / 255.0),
            blue: (20.0 / 255.0),
            alpha: 1.0)
        backgroundColor = UIColor(red: (10.0 / 255.0),
            green: (10.0 / 255.0),
            blue: (10.0 / 255.0),
            alpha: 1.0)
        let bottomBorder = UIView(frame: CGRectMake(self.bounds.minX + 15.0,
            (self.bounds.maxY - 0.5),
            (self.bounds.width - 30.0),
            0.5))
        bottomBorder.backgroundColor = UIColor.darkGrayColor()
        addSubview(bottomBorder)
    }
    
    func setSettingNameWith(name: String) {
        if let nameLabel = settingNameLabel {
            nameLabel.textColor = UIColor.whiteColor()
            nameLabel.text = name
        }
    }
}