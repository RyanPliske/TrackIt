import Foundation

class ToolBarForPickerView : UIToolbar {
    
    var toolBarTitle : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.barStyle = UIBarStyle.Black
        self.toolBarTitle = UILabel(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
    }
    
    func setTitleAttributes(){
        if let title = self.toolBarTitle{
            title.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
            title.textAlignment = NSTextAlignment.Center
            title.textColor = UIColor.grayColor()
        }
    }
    
    func setItemLayout(){
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}