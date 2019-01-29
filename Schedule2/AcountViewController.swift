//
//  AcountViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/01/27.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class AcountViewController: UIViewController {
    
    
    @IBOutlet weak var userName: UILabel!
    
    var userProfile : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnUserData()

        // Do any additional setup after loading the view.
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me",
                                                                 parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil)
            {
                // エラー処理
                
            }
            else
            {
                // プロフィール情報をディクショナリに入れる
                self.userProfile = result as! NSDictionary
                print(self.userProfile)
                //名前
                self.userName.text = self.userProfile.object(forKey: "name") as? String
            }
        })
        
    }
    
//    ログアウト処理
    @IBAction func logout(_ sender: UIButton) {
        let loginManager : FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択
        let login = storyboard.instantiateViewController(withIdentifier: "login")
        self.present(login, animated: true, completion: nil)
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
