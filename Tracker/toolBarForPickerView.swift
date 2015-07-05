//
//  toolBarForPickerView.swift
//  Tracker
//
//  Created by Ryan Pliske on 7/4/15.
//  Copyright © 2015 Tracker. All rights reserved.
//

import Foundation

class toolBarForPickerView : UIToolbar {
    
    // let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "userPicked:")
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    // let toolBarTitle = UILabel(frame: CGRectMake(0, 0, toolBar.bounds.size.width, toolBar.bounds.size.height))
    var toolBarTitle : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.barStyle = UIBarStyle.Black
        self.toolBarTitle = UILabel(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}