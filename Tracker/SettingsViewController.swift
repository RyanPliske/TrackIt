import UIKit

class SettingsViewController: FXFormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        // self.view.frame.size.height = 450
        self.view.backgroundColor = UIColor.blackColor()
        self.tableView.backgroundColor = UIColor.blackColor()
    }
    
    override func awakeFromNib() {
        
        formController.form = SettingsForm()
    }
    
    override func viewWillAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

}
