//
//  mon_1_ViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/02/03.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit
import FacebookLogin
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class new_class_ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var choice_class: UITextField!
    var pickerView: UIPickerView = UIPickerView()
    
    
    @IBOutlet weak var class_name_field: UITextField!
    @IBOutlet weak var room_name_field: UITextField!
    @IBOutlet weak var title_label: UILabel!
    
    
    var receive_indexPath: String = ""
    var receive_day: String = ""
    var give_class_name: String = ""
    var give_class_room: String = ""
    
    var class_name_list: Array<String> = []
    var class_room_list: Array<String> = []
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        room_name_field.delegate = self
        title_label.text = receive_day
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let daigaku = UserDefaults.standard.string(forKey: "daigaku")
        let gakubu = UserDefaults.standard.string(forKey: "gakubu")
        
        
        
        if daigaku != nil && gakubu != nil {
            ref.child("classes/\(daigaku!)/\(gakubu!)/\(self.receive_indexPath)").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                if value != nil{
                    for (key1, value1) in value!{
                        self.class_name_list.append(key1 as! String)
                    }
                    for class_name in self.class_name_list{
                        let class_name_dictionary = value![class_name] as! NSDictionary
                        let room_name = class_name_dictionary["room_name"] as! String
                        
                        self.class_room_list.append(room_name)
                    }
                    
                }
            })
        }
        
        
        if daigaku != nil && gakubu != nil{
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            
            let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
            let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(daigakuEditViewController.done))
            let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(daigakuEditViewController.cancel))
            toolbar.setItems([cancelItem, doneItem], animated: true)
            
            self.choice_class.inputView = pickerView
            self.choice_class.inputAccessoryView = toolbar
        } else {
            choice_class.isHidden = true
        }
        
        
        
        
        
        var choose_class_name: String = ""
        var choose_class_room: String = ""
        
        
        
        
        
        
        
        
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return daigaku_list.count
        
        return self.class_name_list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return daigaku_list[row]
        self.give_class_name = class_name_list[row]
        self.give_class_room = class_room_list[row]
        return "\(class_name_list[row])     \(class_room_list[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        self.daigaku.text = daigaku_list[row]
        if class_name_list != [] && class_room_list != [] {
            self.choice_class.text = "\(class_name_list[row])     \(class_room_list[row])"
        }
        
    }
    
    @objc func cancel() {
//        self.daigaku.text = ""
//        self.daigaku.endEditing(true)
        self.choice_class.text = ""
        self.choice_class.endEditing(true)
    }
    
    @objc func done() {
//        self.daigaku.endEditing(true)
        if self.class_name_list != [] {
            self.choice_class.endEditing(true)
            
            //                UserDefaultに授業を登録
            var class_array = UserDefaults.standard.array(forKey: "class_name")! as! Array<String>
            class_array[Int(receive_indexPath)!] = self.give_class_name
            UserDefaults.standard.set(class_array, forKey: "class_name")
            //                UserDeafultsに教室を登録
            var room_array = UserDefaults.standard.array(forKey: "room_name")! as! Array<String>
            room_array[Int(receive_indexPath)!] = self.give_class_room
            UserDefaults.standard.set(room_array, forKey: "room_name")
            print(UserDefaults.standard.array(forKey: "room_name") as! Array<String>)
            go_to_timeSchedule()
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func update_class(_ sender: Any) {
        if class_name_field.text != "" && room_name_field.text != "" {
            let class_name = self.class_name_field.text!
            let room_name = self.room_name_field.text!
            //            大学、学部が登録されている場合DBにも授業、教室を登録
            if UserDefaults.standard.string(forKey: "daigaku") != nil && UserDefaults.standard.string(forKey: "gakubu") != nil {
                let daigaku = UserDefaults.standard.string(forKey: "daigaku")
                let gakubu = UserDefaults.standard.string(forKey: "gakubu")
                //                DBに授業を登録
                var ref: DatabaseReference!
                ref = Database.database().reference()
                ref.child("classes/\(daigaku!)/\(gakubu!)/\(receive_indexPath)/\(class_name)").updateChildValues(["indexPath": receive_indexPath, "class_name": class_name, "room_name": room_name])
                // 大学、学部が登録されていない場合、not_daigaku_registerにtrueを代入する。updatefileできないようにする
            } else {
                print("rrrrrrrrrrrrrrrrrrrrrrrr")
                var not_daigaku_register = UserDefaults.standard.array(forKey: "not_daigaku_register")! as! Array<String>
                not_daigaku_register[Int(receive_indexPath)!] = "true"
                UserDefaults.standard.set(not_daigaku_register, forKey: "not_daigaku_register")
                print(UserDefaults.standard.array(forKey: "not_daigaku_register") as! Array<String>!)
                
            }
            //                UserDefaultに授業を登録
            var class_array = UserDefaults.standard.array(forKey: "class_name")! as! Array<String>
            class_array[Int(receive_indexPath)!] = class_name
            UserDefaults.standard.set(class_array, forKey: "class_name")
            //                UserDeafultsに教室を登録
            var room_array = UserDefaults.standard.array(forKey: "room_name")! as! Array<String>
            room_array[Int(receive_indexPath)!] = room_name
            UserDefaults.standard.set(room_array, forKey: "room_name")
            

            //                timeScheduleに遷移
            go_to_timeSchedule()
        }
    }
    
    
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    //Enterを押したらキーボードが閉じるようにする
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
//    timeScheduleに移動するメソッド
    func go_to_timeSchedule() {
        //まずは、同じstororyboard内であることをここで定義します
        let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択
        let timeschedule = storyboard.instantiateViewController(withIdentifier: "timeschedule")
        //ここが実際に移動するコードとなります
        self.present(timeschedule, animated: true, completion: nil)
    }
    
    func go_to_classView(){
        //まずは、同じstororyboard内であることをここで定義します
        let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択
        let timeschedule = storyboard.instantiateViewController(withIdentifier: "newTodetail")
        //ここが実際に移動するコードとなります
        self.present(timeschedule, animated: true, completion: nil)
    }
    
    // 画面遷移先のViewControllerを取得し、データを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newTodetail" {
            let vc = segue.destination as! ClassViewController
            vc.recieve_indexPath = self.receive_indexPath
            vc.recieve_class_name = self.give_class_name
        }
    }
    
}
