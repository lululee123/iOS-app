//
//  UserAboutViewController.swift
//  LegendEats
//
//  Created by 宋佺儒 on 2017/5/13.
//  Copyright © 2017年 宋佺儒. All rights reserved.
//

import UIKit

class UserAboutViewController: UIViewController {
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var copyright: UIImageView!
    @IBAction func link(_ sender: UIButton) {
        if let url = URL(string: "https://www.facebook.com/Legend-Eats-1367898509965698/") {
            UIApplication.shared.openURL(url)
            //UIApplication.shared.open(url, options: [:]) {
                //boolean in
                // do something with the boolean
            //}
        }
        
    }
    override func viewDidLoad() {
        self.title = "About Legend Eats"
        super.viewDidLoad()
        self.coverImage.layer.cornerRadius = 6.4
        self.coverImage.clipsToBounds = true
        self.copyright.layer.cornerRadius = 9
        self.copyright.clipsToBounds = true
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
