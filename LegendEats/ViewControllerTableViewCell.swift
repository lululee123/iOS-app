//
//  ViewControllerTableViewCell.swift
//  appproject
//
//  Created by 李文慈 on 2017/4/27.
//  Copyright © 2017年 lulu. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var emaillb: UILabel!
    @IBOutlet weak var countlb: UILabel!
    @IBOutlet weak var meallb: UILabel!
    @IBOutlet weak var timelb: UILabel!
    
    
    @IBOutlet weak var getemaillb: UILabel!
    @IBOutlet weak var getmeallb: UILabel!
    @IBOutlet weak var getcountlb: UILabel!
    @IBOutlet weak var getnotelb: UILabel!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
