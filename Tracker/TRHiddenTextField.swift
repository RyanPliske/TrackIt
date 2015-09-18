import Foundation

class TRHiddenTextField: UITextField {
    override func caretRectForPosition(position: UITextPosition) -> CGRect {
        return CGRectZero
    }
}