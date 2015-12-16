import UIKit

class TREditItemViewController: UIViewController {
    
    //TODO: Replace this
    var itemRowToPopulateWith: Int!
    
    var itemsModel: TRItemsModel!
    
    @IBOutlet private weak var itemTableView: UITableView!
    private var editItemPresenter: TREditItemPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editItemPresenter = TREditItemPresenter(view: itemTableView, itemRowToPopulateWith: itemRowToPopulateWith, itemsModel: itemsModel)
        let pageTitle = itemRowToPopulateWith != nil ? "Item" : "New Item"
        title = pageTitle
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        editItemPresenter.fuckingResignFirstResponder()
    }
    
}
