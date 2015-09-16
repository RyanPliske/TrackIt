import Foundation

class TREditItemViewController: UIViewController {
    
    @IBOutlet weak var itemTableView: TRSettingsTableView!

    private var editItemPresenter: TREditItemPresenter!
    var itemRowToPopulateWith: Int?
    
    override func viewDidLoad() {
        editItemPresenter = TREditItemPresenter(view: itemTableView, itemRowToPopulateWith: itemRowToPopulateWith)
        let pageTitle = itemRowToPopulateWith != nil ? "Item" : "New Item"
        title = pageTitle
    }
    
}
