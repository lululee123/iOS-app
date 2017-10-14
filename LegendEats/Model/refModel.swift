//
//  refModel.swift
//  appproject
//
//  Created by 李文慈 on 2017/4/27.
//  Copyright © 2017年 lulu. All rights reserved.
//

class refModel
{
    var email: String?
    var meal: String?
    var count: String?
    var time: String?
    var note: String?
    
    
    init(email: String?, meal: String?, count: String?, time: String?, note: String?)
    {
        self.email = email;
        self.meal = meal;
        self.count = count;
        self.time = time;
        self.note = note;
    }
}
