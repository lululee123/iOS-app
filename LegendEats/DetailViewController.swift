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

class DetailViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var stepper: GMStepper!
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var prepTime: UILabel?
    
    var recipe: Recipe?
    var studentId: String = (FIRAuth.auth()?.currentUser?.email)!
    var result: String?
    var finish : String = "No"
    
    @IBOutlet weak var note: UITextField!
    @IBOutlet weak var lbmeal: UILabel!
    @IBOutlet weak var lbpicker: UIPickerView!
    var meals = [String]()
    
    @IBAction func submit(_ sender: UIButton)
    {
        if lbmeal.text! == "今天想吃？" || lbmeal.text! == "--請下拉選擇餐點--" || stepper.value == 0.0
        {
            let alertController = UIAlertController(title:"尚未完成訂餐", message:"返回訂餐", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ok!!", style: UIAlertActionStyle.default, handler:nil))
            present(alertController, animated: true, completion: nil)
        }
        else
        {
            data()
            let alertController = UIAlertController(title:"訂餐完成", message:"祝您用餐愉快", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ok!!", style: UIAlertActionStyle.default, handler:nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.note.delegate = self
        navigationItem.title = recipe?.name
        imageView?.image = UIImage(named: recipe!.thumbnails)
        nameLabel?.text = recipe!.name
        prepTime?.text = "Prep Time: " + recipe!.prepTime
        lbpicker.delegate = self
        stepper.addTarget(self, action: #selector(DetailViewController.stepperValueChanged), for: .valueChanged)
        ref = FIRDatabase.database().reference().child("student")
        lbmeal.layer.borderWidth = 2.0
        lbmeal.layer.cornerRadius = 8
        lbmeal.layer.borderColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        //當前系統日期
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        result = formatter.string(from: date)
        
        if nameLabel?.text == "李媽媽"
        {
            meals = ["--請下拉選擇餐點--","麵 $60", "飯 $60"]
        }
        else if nameLabel?.text == "品客自助餐"
        {
            meals = ["--請下拉選擇餐點--","排骨 $70", "雞腿 $70"]
        }
        else if nameLabel?.text == "豪享來"
        {
            meals = ["--請下拉選擇餐點--","炒泡麵 $50", "炒意麵 $50"]
        }
        else if nameLabel?.text == "古早味"
        {
            meals = ["--請下拉選擇餐點--","滷肉飯 $35", "雞肉飯 $35"]
        }
        else if nameLabel?.text == "李爸爸"
        {
            meals = ["--請下拉選擇餐點--","麵 $160", "飯 $160"]
        }
        else if nameLabel?.text == "品嗑自助餐"
        {
            meals = ["--請下拉選擇餐點--","排骨 $170", "雞腿 $170"]
        }
        else if nameLabel?.text == "豪享吃"
        {
            meals = ["--請下拉選擇餐點--","炒泡麵 $150", "炒意麵 $150"]
        }
        else if nameLabel?.text == "古早味分店"
        {
            meals = ["--請下拉選擇餐點--","滷肉飯 $135", "雞肉飯 $135"]
        }
        

    }
    func numberOfComponent(in pickerView: UIPickerView) ->Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) ->Int
    {
        return meals.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent: Int) ->String?
    {
        return meals[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        lbmeal.text = meals[row]
        if meals[row] == "--請下拉選擇餐點--" {
            lbmeal.text = "今天想吃？"
        }
    }
    func stepperValueChanged(stepper: GMStepper) {
        print(stepper.value, terminator: "")
    }
    func data()
    {
        let key = ref.childByAutoId().key
        let dilimiter = " "
        let meal = lbmeal.text?.components(separatedBy: dilimiter)
        
        let student: [String: Any] = [
            "學號信箱":studentId,
            "餐廳名稱":nameLabel?.text,
            "餐點":meal![0] as String,
            "數量":String(Int(stepper.value)) as String,
            "訂購時間":result,
            "備註":note.text! as String,
            "完成":finish
        ]
        ref.child(key).setValue(student)
    }
    
    // 按畫面結束編輯
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // 按return結束編輯
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        note.resignFirstResponder()
        return (true)
    }
  
    
}
