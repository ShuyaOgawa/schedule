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

class new_class_ViewController: UIViewController {
    
    @IBOutlet weak var class_name_field: UITextField!
    @IBOutlet weak var room_name_field: UITextField!
    @IBOutlet weak var title_label: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

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
            //firebaseデータベースにuser追加
            let user = Auth.auth().currentUser
            let user_id = user?.uid
            let class_name = self.class_name_field.text
            let room_name = self.room_name_field.text
            ref.child("classes/mon_1").updateChildValues(["class_name": class_name!, "room_name": room_name!])
            self.dismiss(animated: true)
        }
    }
    
    
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
