import UIKit

class TRGraphCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var graphView: TRGraphView!
    
    func setStartColor(color: UIColor) {
        graphView.startColor = color
    }
    
    func setDelegate(delegate: TRGraphViewDelegate) {
        graphView.delegate = delegate
    }
    
}