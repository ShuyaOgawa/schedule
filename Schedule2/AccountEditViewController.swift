//
//  AccountEditViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/01/29.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit
import FacebookLogin
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class AccountEditViewController: UIViewController {
    

    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var user_image: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if Auth.auth().currentUser != nil {
            // User is signed in.
            
        } else {
            // No user is signed in.
            self.dismiss(animated: true)
        }
        
        
    }
    
    @IBAction func backToAcountview(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func update_profile(_ sender: Any) {
        //    firebaseのデータベース取得
        var ref: DatabaseReference!
        ref = Database.database().reference()
        //firebaseデータベースにuser追加
        let user = Auth.auth().currentUser
        let user_id = user?.uid
        let nickName = self.nickName.text
        ref.child("users/\(user_id!)").updateChildValues(["nickName": nickName!])
        
        //まずは、同じstororyboard内であることをここで定義します
        let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択
        let AccountView = storyboard.instantiateViewController(withIdentifier: "AccountView")
        //ここが実際に移動するコードとなります
        self.present(AccountView, animated: true, completion: nil)
    }
    
    
    @IBAction func image_button(_ sender: Any) {
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
