import Foundation

class TREditItemViewController: UIViewController {
    
    @IBOutlet weak var itemTableView: TRSettingsTableView!

    private var editItemPresenter: TREditItemPresenter!
    
    override func viewDidLoad() {
        editItemPresenter = TREditItemPresenter(view: itemTableView)
    }
    
}
