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
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let user = Auth.auth().currentUser
            let user_id = user?.uid
            
//            編集途中　大学学部参照
            ref.child("users/\(user_id!)").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                if value != nil {
                    let daigaku = value?["daigaku"] as? String
                    let gakubu = value?["gakubu"] as? String
                }
            }) { (error) in
                print(error.localizedDescription)
            }
            
            //firebaseデータベースにuser追加
            let class_name = self.class_name_field.text!
            let room_name = self.room_name_field.text!
            ref.child("classes/\(receive_indexPath)").updateChildValues(["indexPath": receive_indexPath, "class_name": class_name, "room_name": room_name])
            //まずは、同じstororyboard内であることをここで定義します
            let storyboard: UIStoryboard = self.storyboard!
            //ここで移動先のstoryboardを選択
            let timeschedule = storyboard.instantiateViewController(withIdentifier: "timeschedule")
            //ここが実際に移動するコードとなります
            self.present(timeschedule, animated: true, completion: nil)
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
    
}
