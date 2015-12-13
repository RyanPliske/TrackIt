import UIKit

class TREditItemViewController: UIViewController {
    
    var itemRowToPopulateWith: Int!
    
    @IBOutlet private weak var itemTableView: UITableView!
    private var editItemPresenter: TREditItemPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editItemPresenter = TREditItemPresenter(view: itemTableView, itemRowToPopulateWith: itemRowToPopulateWith, itemsModel: TRItemsModel.sharedInstanceOfItemsModel)
        let pageTitle = itemRowToPopulateWith != nil ? "Item" : "New Item"
        title = pageTitle
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        editItemPresenter.fuckingResignFirstResponder()
    }
    
}
