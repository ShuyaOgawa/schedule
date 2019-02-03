//
//  SchesuleViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/02/02.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit
import FacebookLogin
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var mon_1: UIView!
    @IBOutlet weak var class_name_label: UILabel!
    @IBOutlet weak var room_name_label: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mon_1_class()

        // Do any additional setup after loading the view.
    }
    
    func mon_1_class(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("classes/mon_1").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let class_name = value?["class_name"] as? String?
            let room_name = value?["room_name"] as? String?
            if class_name != nil && room_name != nil {
                self.mon_1.backgroundColor = UIColor.init(red: 230/255, green: 255/255, blue: 255/255, alpha: 95/100)
                self.class_name_label.text = class_name!
                self.room_name_label.text = room_name!
            } else {
                
            }
            
        }) { (error) in
            print(error.localizedDescription)
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
    @IBAction func mon_1_push(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("classes/mon_1").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let class_name = value?["class_name"] as? String?
            let room_name = value?["room_name"] as? String?
            if class_name != nil && room_name != nil {
            } else {
                //まずは、同じstororyboard内であることをここで定義します
                let storyboard: UIStoryboard = self.storyboard!
                //ここで移動先のstoryboardを選択
                let mon_1 = storyboard.instantiateViewController(withIdentifier: "mon_1")
                //ここが実際に移動するコードとなります
                self.present(mon_1, animated: true, completion: nil)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
