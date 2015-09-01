import Foundation

class TRSettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var settingNameLabel: UILabel!
    
    func setSettingNameWith(name: String) {
        if let nameLabel = settingNameLabel {
            nameLabel.text = name
        }
    }
}