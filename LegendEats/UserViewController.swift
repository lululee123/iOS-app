//
//  ViewControllerTableViewCell.swift
//  appproject
//
//  Created by 李文慈 on 2017/4/27.
//  Copyright © 2017年 lulu. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class UserViewController: UIViewController{
    
    
    @IBAction func LogOutAction(_ sender: Any) {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationItem.title = "User"
        
    }
    

    // MARK: Segue Method
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserOrder" {
            let indexPath = self.tableView!.indexPathForSelectedRow
            let destinationViewController: UserOrderViewController = segue.destination as! UserOrderViewController
            //destinationViewController.userOptions = userOptions[indexPath!.row]
            
        }
    }*/

}
