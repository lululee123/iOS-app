//
//  RestaurantViewController.swift
//  LegendEats
//
//  Created by 李文慈 on 2017/5/13.
//  Copyright © 2017年 宋佺儒. All rights reserved.
//

import UIKit
import Firebase


struct Restaurant {
    let restaurantName: String
    let restaurantEmail: String
}

class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var sheet = [refModel]()
    var restaurantReceived = [Restaurant]()
    var keyForFinish : [String] = []
    var keyForFinishIndex : Int = 0
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheet.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ViewControllerTableViewCell
        cell.contentView.backgroundColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        cell.contentView.layer.cornerRadius = 7.0
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 18, height: 142))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [255.0, 255.0, 255.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 7.0
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
        let sheetdata: refModel
        sheetdata = sheet[indexPath.row]
        cell.getemaillb.text = sheetdata.email
        cell.getmeallb.text = sheetdata.meal
        cell.getcountlb.text = sheetdata.count
        cell.getnotelb.text = sheetdata.note
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref2 = FIRDatabase.database().reference().child("blockstudent")
        let query = FIRDatabase.database().reference().child("student").queryOrdered(byChild:"餐廳名稱").queryEqual(toValue: restaurantReceived[0].restaurantName)
        query.observe(FIRDataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount > 0
            {
                self.sheet.removeAll()
                //print("---------Start---------")
                for student in snapshot.children.allObjects as![FIRDataSnapshot]
                {
                    let sheetOjbect = student.value as? [String: AnyObject]
                    let sheetemail = sheetOjbect?["學號信箱"] as! String?
                    let sheetmeal = sheetOjbect?["餐點"] as! String?
                    let sheetcount = sheetOjbect?["數量"] as! String?
                    let sheettime = sheetOjbect?["訂購時間"] as! String?
                    let sheetnote = sheetOjbect?["備註"] as! String?
                    let sheetfinish = sheetOjbect?["完成"] as! String?
                    
                    if sheetfinish == "Yes" {
                        continue
                    }
                    
                    self.keyForFinish.insert(student.key, at: self.keyForFinishIndex)
                    self.keyForFinishIndex += 1
    
                    //print(self.keyForFinish)
                    
                    let sheetdata = refModel(email: sheetemail, meal: sheetmeal, count: sheetcount, time: sheettime, note: sheetnote)
                    self.sheet.append(sheetdata)
                }
                //print("---------End---------\n\n\n")
                self.table.reloadData()
            }
        })
    }
   
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let black = UITableViewRowAction(style: .default, title: "黑名單") {(action, index) in
            let alertController = UIAlertController(title:"確定要將這位同學加入黑名單嗎？", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.destructive, handler: {action in
                let finishRef  = FIRDatabase.database().reference().child("student").child(self.keyForFinish[indexPath.row])
                finishRef.updateChildValues(["完成":"Yes"])
                //print(self.keyForFinish[indexPath.row])
                self.keyForFinish.removeAll()
                self.keyForFinishIndex = 0
                
                let sheetdata: refModel
                sheetdata = self.sheet[indexPath.row]
                let key = ref2.childByAutoId().key
                let student = [ "student number": sheetdata.email as String!
                ]
                ref2.child(key).setValue(student)
                self.sheet.remove(at: indexPath.row)
                self.table.deleteRows(at: [indexPath], with: .fade)
                }))
            alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler:nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        black.backgroundColor = UIColor.black
        let done = UITableViewRowAction(style: .destructive, title: "完成") {(action, index) in
            self.sheet.remove(at: indexPath.row)
            self.table.deleteRows(at: [indexPath], with: .fade)
            let finishRef  = FIRDatabase.database().reference().child("student").child(self.keyForFinish[indexPath.row])
            finishRef.updateChildValues(["完成":"Yes"])
            //print(self.keyForFinish[indexPath.row])
            self.keyForFinish.removeAll()
            self.keyForFinishIndex = 0
        }
        done.backgroundColor = UIColor.red
       
        return[done, black]
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
