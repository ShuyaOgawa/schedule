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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // ログイン済みかチェック
        if let token = FBSDKAccessToken.current() {
            let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if error != nil {
                    // ...
                    return
                }
                // ログイン時の処理
                //まずは、同じstororyboard内であることをここで定義します
                let storyboard: UIStoryboard = self.storyboard!
                //ここで移動先のstoryboardを選択(今回の場合は先ほどsecondと名付けたのでそれを書きます)
                let timeschedule = storyboard.instantiateViewController(withIdentifier: "timeschedule")
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
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    // Logout callback
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
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
