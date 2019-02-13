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

class new_class_ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var class_name_field: UITextField!
    @IBOutlet weak var room_name_field: UITextField!
    @IBOutlet weak var title_label: UILabel!
    
    
    var receive_indexPath: String = ""
    var receive_day: String = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        room_name_field.delegate = self
        title_label.text = receive_day
        // Do any additional setup after loading the view.
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
        if class_name_field.text != nil && room_name_field.text != nil {
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
                }
            //                UserDefaultに授業を登録
            var class_array = UserDefaults.standard.array(forKey: "class_name")! as! Array<String>
            class_array[Int(receive_indexPath)!] = class_name
            UserDefaults.standard.set(class_array, forKey: "class_name")
            //                UserDeafultsに教室を登録
            var room_array = UserDefaults.standard.array(forKey: "room_name")! as! Array<String>
            room_array[Int(receive_indexPath)!] = room_name
            UserDefaults.standard.set(room_array, forKey: "room_name")
            print(UserDefaults.standard.array(forKey: "room_name") as! Array<String>)
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
    
}
