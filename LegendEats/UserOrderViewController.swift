//
//  UserOrderViewController.swift
//  LegendEats
//
//  Created by 宋佺儒 on 2017/5/3.
//  Copyright © 2017年 宋佺儒. All rights reserved.
//

import UIKit
import Firebase

class UserOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var table: UITableView!

    var sheet = [refModel]()
    var studentId: String = (FIRAuth.auth()?.currentUser?.email)!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheet.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        cell.contentView.backgroundColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        cell.contentView.layer.cornerRadius = 7.0
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 50, height: 172))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [255.0, 255.0, 255.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 7.0
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
        let sheetdata: refModel
        sheetdata = sheet[indexPath.row]
        cell.emaillb.text = sheetdata.email
        cell.meallb.text = sheetdata.meal
        cell.countlb.text = sheetdata.count
        cell.timelb.text = sheetdata.time
        cell.getnotelb.text = sheetdata.note
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "訂單"
        let query = FIRDatabase.database().reference().child("student").queryOrdered(byChild: "學號信箱").queryEqual(toValue: studentId)
        query.observe(FIRDataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0
            {
                self.sheet.removeAll()
                
                for student in snapshot.children.allObjects as![FIRDataSnapshot]
                {
                    let sheetOjbect = student.value as? [String: AnyObject]
                    let sheetemail = sheetOjbect?["餐廳名稱"] as! String?
                    let sheetmeal = sheetOjbect?["餐點"] as! String?
                    let sheetcount = sheetOjbect?["數量"] as! String?
                    let sheettime = sheetOjbect?["訂購時間"] as! String?
                    let sheetnote = sheetOjbect?["備註"] as! String?
                    let sheetdata = refModel(email: sheetemail, meal: sheetmeal, count: sheetcount, time: sheettime, note: sheetnote)
                    self.sheet.append(sheetdata)
                }
                
                self.table.reloadData()
            }
        })
        

        //撈出指定學號的指定資料
        /*let query = FIRDatabase.database().reference().child("student").queryOrdered(byChild: "student number").queryEqual(toValue : "B10215049")
        
        query.observe(.value, with:{ (snapshot: FIRDataSnapshot) in
            for snap in snapshot.children {
                print((snap as! FIRDataSnapshot).childSnapshot(forPath: "meal"))
            }
        })*/
        
        //let userID = FIRAuth.auth()?.currentUser?.uid
        //print(userID)
        
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
