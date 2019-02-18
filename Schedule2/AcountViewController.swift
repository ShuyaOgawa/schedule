//
//  AcountViewController.swift
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

class AcountViewController: UIViewController {
    
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var user_image: UIImageView!
    @IBOutlet weak var daigaku_label: UILabel!
    @IBOutlet weak var gakubu_label: UILabel!
    
    
    var userProfile : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//user_nameがuserDefaultsに登録されていたら表示
        if UserDefaults.standard.string(forKey: "user_name") != nil {
            self.userName.text = (UserDefaults.standard.string(forKey: "user_name"))!
        }
        if UserDefaults.standard.string(forKey: "daigaku") != nil {
            self.daigaku_label.text = (UserDefaults.standard.string(forKey: "daigaku"))!
            self.daigaku_label.textColor = UIColor.black
        }
        if UserDefaults.standard.string(forKey: "gakubu") != nil {
            self.gakubu_label.text = (UserDefaults.standard.string(forKey: "gakubu"))!
            self.gakubu_label.textColor = UIColor.black
        }
        
//                    トプ画をストレージから取得
        let user_id = UserDefaults.standard.string(forKey: "user_id")
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: "gs://schedule-7b17a.appspot.com")
        let riversRef = storageRef.child("user_image/" + user_id! + ".jpg")
        riversRef.getData(maxSize: 20 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error)
            } else {
            // Data for "images/island.jpg" is returned
                let image: UIImage? = data.flatMap(UIImage.init)
                self.user_image.image = image
                self.user_image.layer.cornerRadius = 40
                self.user_image.layer.masksToBounds = true
            }
        }
        
        
        //ニックネームが登録されていたらfirebaseからさ取得。そうでなければfacebookの名前取得。
//        let user_id = Auth.auth().currentUser?.uid
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        ref.child("users/\(user_id!)").observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let nickName = value?["nickName"] as? String?
//            let user_image_data = value?["user_image"] as? String?
//            let daigaku = value?["daigaku"] as? String?
//            let gakubu = value?["gakubu"] as? String?
//            if nickName != nil {
//                self.userName.text = nickName!
//            } else {
//                self.returnUserData()
//            }
//
//            if daigaku != nil{
//                self.daigaku_label.text = daigaku!
//                self.daigaku_label.textColor = UIColor.black
//            } else {
//                self.returnUserData()
//            }
//
//            if gakubu != nil {
//                self.gakubu_label.text = gakubu!
//                self.gakubu_label.textColor = UIColor.black
//            } else {
//                self.returnUserData()
//            }
        
//            if user_image_data != nil {
                //空白を+に変換する
//                var base64String = user_image_data!?.replacingOccurrences(of: " ", with:"+",range:nil)
            
                //BASE64の文字列をデコードしてNSDataを生成
//                let decodeBase64:NSData? =
//                    NSData(base64Encoded:base64String!, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
            
                //NSDataの生成が成功していたら
//                let decodeSuccess = decodeBase64
            
                //NSDataからUIImageを生成
//                let img = UIImage(data: decodeSuccess as! Data)
            
//                self.user_image.image = img
//                self.user_image.layer.cornerRadius = 40
//                self.user_image.layer.masksToBounds = true
            
//            }
            
//            トプ画をストレージから取得
//            let storage = Storage.storage()
//            let storageRef = storage.reference(forURL: "gs://schedule-7b17a.appspot.com")
//            let riversRef = storageRef.child("user_image/" + user_id! + ".jpg")
//            riversRef.getData(maxSize: 20 * 1024 * 1024) { data, error in
//
//                if let error = error {
//                    // Uh-oh, an error occurred!
//                    print(error)
//                } else {
//                    // Data for "images/island.jpg" is returned
//                    let image: UIImage? = data.flatMap(UIImage.init)
//                    self.user_image.image = image
//                    self.user_image.layer.cornerRadius = 40
//                    self.user_image.layer.masksToBounds = true
//                }
//
//            }
//
//
//
//
//
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//
        
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
                //名前
                self.userName.text = self.userProfile.object(forKey: "name") as? String
            }
        })
        
    }
    
//    ログアウト処理
    @IBAction func logout(_ sender: UIButton) {
        
        
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert: UIAlertController = UIAlertController(title: "ログアウト", message: "時間割がリセットされますがいいですか？", preferredStyle:  UIAlertController.Style.alert)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            //        UserDefaiultsのuser_id、class_name、room_name削除
            UserDefaults.standard.removeObject(forKey: "user_id")
            UserDefaults.standard.removeObject(forKey: "class_name")
            UserDefaults.standard.removeObject(forKey: "room_name")
            UserDefaults.standard.removeObject(forKey: "user_name")
            UserDefaults.standard.removeObject(forKey: "daigaku")
            UserDefaults.standard.removeObject(forKey: "gakubu")
            let loginManager : FBSDKLoginManager = FBSDKLoginManager()
            loginManager.logOut()
            //ここで移動先のstoryboardを選択
            let storyboard: UIStoryboard = self.storyboard!
            let login = storyboard.instantiateViewController(withIdentifier: "login")
            self.present(login, animated: true, completion: nil)
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        self.present(alert, animated: true, completion: nil)
        
        
        
        

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
