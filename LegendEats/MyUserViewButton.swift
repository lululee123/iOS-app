//
//  MyButton.swift
//  LegendEats
//
//  Created by 宋佺儒 on 2017/5/15.
//  Copyright © 2017年 宋佺儒. All rights reserved.
//

import UIKit

class MyButton: SimpleButton {
    
    override func configureButtonStyles() {
        super.configureButtonStyles()
        setBorderWidth(4.0, for: .normal)
        setShadowColor(UIColor(red: 0/255, green: 1/255, blue: 190/255, alpha: 1.0), for : .normal)
        setBackgroundColor(UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0), for: .normal)
        setBackgroundColor(UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0), for: .highlighted)
        setBorderColor(UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0), for: .normal)
        setScale(0.98, for: .highlighted)
        setTitleColor(UIColor.white, for: .normal)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
