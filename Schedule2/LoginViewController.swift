//
//  LoginViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/01/27.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit
import FacebookLogin
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBAction func backToTop(segue: UIStoryboardSegue) {}
    
    var ActivityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.array(forKey: "class_name") == nil {
            let class_array: Array = ["",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "", ""]
            UserDefaults.standard.set(class_array, forKey: "class_name")
        }
        
        if UserDefaults.standard.array(forKey: "room_name") == nil {
            let room_array: Array = ["",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "", ""]
            UserDefaults.standard.set(room_array, forKey: "room_name")
        }
        if UserDefaults.standard.array(forKey: "not_daigaku_register") == nil {
            let not_daigaku_register: Array = ["",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "", ""]
            UserDefaults.standard.set(not_daigaku_register, forKey: "not_daigaku_register")
        }
        
        
        if UserDefaults.standard.object(forKey: "user_id") != nil && UserDefaults.standard.object(forKey: "daigaku") != nil {
            let storyboard: UIStoryboard = self.storyboard!
            let timeschedule = storyboard.instantiateViewController(withIdentifier: "timeschedule")
            self.present(timeschedule, animated: true, completion: nil)
        }
        
        // ActivityIndicatorを作成＆中央に配置
        
        ActivityIndicator = UIActivityIndicatorView()
        ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        ActivityIndicator.center = self.view.center
        
        // クルクルをストップした時に非表示する
        ActivityIndicator.hidesWhenStopped = true
        
        // 色を設定
        ActivityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        
        //Viewに追加
        self.view.addSubview(ActivityIndicator)
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
//        アカウント作成していたときuserdefaultのuser_idを参照してtimescheduleに移動
//         ログアウト時はuserDefaultsは削除されているからここ経由しない
        if UserDefaults.standard.object(forKey: "user_id") != nil {
            
            //まずは、同じstororyboard内であることをここで定義します
            let storyboard: UIStoryboard = self.storyboard!
            //ここで移動先のstoryboardを選択
//            let timeschedule = storyboard.instantiateViewController(withIdentifier: "timeschedule")
            
//            let timeschedule = storyboard.instantiateViewController(withIdentifier: "daigaku_register")
//            //ここが実際に移動するコードとなります
//            self.present(timeschedule, animated: true, completion: nil)
            
            if UserDefaults.standard.object(forKey: "daigaku") == nil {
                let timeschedule = storyboard.instantiateViewController(withIdentifier: "daigaku_register")
                self.present(timeschedule, animated: true, completion: nil)
            } else {
                let timeschedule = storyboard.instantiateViewController(withIdentifier: "timeschedule")
                self.present(timeschedule, animated: true, completion: nil)
            }
        }
        
        // ログイン済みかチェック
        
        if let token = FBSDKAccessToken.current() {
            // クルクルスタート
            self.ActivityIndicator.startAnimating()
            let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if error != nil {
                    // ...
                    return
                }
                // ログイン時の処理
                
                //    firebaseのデータベース取得
                var ref: DatabaseReference!
                ref = Database.database().reference()
                //firebaseデータベースにuser追加
                let user = Auth.auth().currentUser
                let user_id = user?.uid
                ref.child("users/\(user_id!)").updateChildValues(["user_id": user_id!])
                
                
//                user_idのuserdefaultshへの書き込み
                UserDefaults.standard.set(user_id!, forKey: "user_id")
                
                
                //まずは、同じstororyboard内であることをここで定義します
                let storyboard: UIStoryboard = self.storyboard!
                //ここで移動先のstoryboardを選択
//                let timeschedule = storyboard.instantiateViewController(withIdentifier: "timeschedule")
                let timeschedule = storyboard.instantiateViewController(withIdentifier: "daigaku_register")
                //ここが実際に移動するコードとなります
                self.present(timeschedule, animated: true, completion: nil)
                
            }
            return
        }
        // ログインボタン設置
        let fbLoginBtn = FBSDKLoginButton()
        fbLoginBtn.readPermissions = ["public_profile", "email"]
        var fbx = self.view.frame.width
        fbx *= 1/2
        var fby = self.view.frame.height
        fby *= 5/6
        fbLoginBtn.layer.position = CGPoint(x: fbx, y:fby)
        fbLoginBtn.delegate = self as? FBSDKLoginButtonDelegate
        self.view.addSubview(fbLoginBtn)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // login callback
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            print("Error")
            return
        }
        // ログイン時の処理
        // クルクルストップ
        self.ActivityIndicator.stopAnimating()
    }
    
    
//    ログアウトボタン
//    @IBAction func logoutButton(_ sender: Any) {
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
//    }
//
//    // Logout callback
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

    
    
    
}
