//
//  SheetViewController.swift
//  appproject
//
//  Created by 李文慈 on 2017/4/20.
//  Copyright © 2017年 lulu. All rights reserved.
//

import UIKit
import Firebase

class SheetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var sheet = [refModel]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheet.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let sheetdata: refModel
        sheetdata = sheet[indexPath.row]
        cell.emaillb.text = sheetdata.email
        cell.meallb.text = sheetdata.meal
        cell.countlb.text = sheetdata.count
        cell.timelb.text = sheetdata.time
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "訂單"
        ref = FIRDatabase.database().reference().child("student")
        ref.observe(FIRDataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0
            {
                self.sheet.removeAll()
                
                for student in snapshot.children.allObjects as![FIRDataSnapshot]
                {
                    let sheetOjbect = student.value as? [String: AnyObject]
                    let sheetemail = sheetOjbect?["學號信箱"]
                    let sheetmeal = sheetOjbect?["餐點"]
                    let sheetcount = sheetOjbect?["數量"]
                    let sheettime = sheetOjbect?["訂餐時間"]
                    let sheetnote = sheetOjbect?["備註"] as! String?
                    let sheetdata = refModel(email: sheetemail as! String?, meal: sheetmeal as! String?, count: sheetcount as! String?, time: sheettime as! String?, note: sheetnote as! String?)
                    self.sheet.append(sheetdata)
                }
                
            self.table.reloadData()
            }
        })
        
        //撈出指定學號的指定資料
        let query = FIRDatabase.database().reference().child("student").queryOrdered(byChild: "student number").queryEqual(toValue : "B10215049")
        
        query.observe(.value, with:{ (snapshot: FIRDataSnapshot) in
            for snap in snapshot.children {
                print((snap as! FIRDataSnapshot).childSnapshot(forPath: "meal"))
            }
        })

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
