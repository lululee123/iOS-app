//
//  RestaurantLoginViewController.swift
//  LegendEats
//
//  Created by 李文慈 on 2017/5/13.
//  Copyright © 2017年 宋佺儒. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RestaurantLoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var passward: UITextField!
    @IBOutlet weak var coverImage: UIImageView!
    
    var restaurants: [Restaurant] = [Restaurant(restaurantName: "李媽媽", restaurantEmail: "Limama@ntust.com"),
                                     Restaurant(restaurantName: "品客自助餐", restaurantEmail: "Pinker@ntust.com"),
                                     Restaurant(restaurantName: "豪享來", restaurantEmail: "Haoxionlai@ntust.com"),
                                     Restaurant(restaurantName: "古早味", restaurantEmail: "Gutzaowei@ntust.com"),
                                     Restaurant(restaurantName: "李爸爸", restaurantEmail: "Limama1@ntust.com"),
                                     Restaurant(restaurantName: "品嗑自助餐", restaurantEmail: "Pinker1@ntust.com"),
                                     Restaurant(restaurantName: "豪享吃", restaurantEmail: "Haoxionlai1@ntust.com"),
                                     Restaurant(restaurantName: "古早味分店", restaurantEmail: "Gutzaowei1@ntust.com"),
                                     
                                    ]
       
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mail.delegate = self
        self.passward.delegate = self
        self.coverImage.layer.cornerRadius = 6.4
        self.coverImage.clipsToBounds = true
        
        //在firebase建立餐廳email
       /* for index in 0 ..< restaurants.endIndex {
            FIRAuth.auth()?.createUser(withEmail: restaurants[index].restaurantEmail, password: "123456")
            {(user, error) in
                 print(self.restaurants[index].restaurantEmail)
            }
        } */
    }
    
    @IBAction func login(_ sender: UIButton) {
        let found = restaurants.filter{ $0.restaurantEmail == self.mail.text}.count > 0
        let foundIndex = restaurants.index{ $0.restaurantEmail == self.mail.text}

        if !found {
            let alertController = UIAlertController(title: "Error", message: "You don't have permission to login!!", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            if self.mail.text == "" || self.passward.text == "" {
                
                //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
                
                let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                
                FIRAuth.auth()?.signIn(withEmail: self.mail.text!, password: self.passward.text!) { (user, error) in
                    
                    if error == nil {
                        
                        //Print into the console if successfully logged in
                        print("You have successfully logged in")
                        
                        //Go to the RecipesTableViewController if the login is sucessful
                        let vc = self.storyboard?.instantiateViewController(withIdentifier:"restaurant") as! RestaurantViewController
                        vc.restaurantReceived.append(self.restaurants[foundIndex!])
                        self.present(vc, animated: true, completion: nil)
                        
                    } else {
                        
                        //Tells the user that there is an error and then gets firebase to tell them the error
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    // 按畫面結束編輯
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // 按return結束編輯
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mail.resignFirstResponder()
        passward.resignFirstResponder()
        return (true)
    }
    
}
