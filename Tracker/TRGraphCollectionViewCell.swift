import UIKit

class TRGraphCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var graphView: TRGraphView!
    
    func set(startColor: UIColor, endColor: UIColor) {
        graphView.startColor = startColor
        graphView.endColor = endColor
    }
    
    func setDelegate(delegate: TRGraphViewDelegate) {
        graphView.delegate = delegate
    }
    
    func reset() {
        graphView.setNeedsDisplay()
    }
    
}