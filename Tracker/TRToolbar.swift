import Foundation

class TRToolbar: UIToolbar {
    
    init(frame: CGRect, parentView: UIView) {
        super.init(frame: frame)
        setup(parentView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(parentView: UIView) {
        let doneButton = UIBarButtonItem(title: "Track", style: UIBarButtonItemStyle.Plain, target: parentView, action: "userPickedAnItemToTrack:")
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: parentView, action: "userCanceledPicking:")
        setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        barStyle = UIBarStyle.Black
    }
}