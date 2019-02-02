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

class AccountEditViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var user_image: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickName.delegate = self
        
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
    
    
//    ユーザ編集の更新ボタン
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
    
    //Enterを押したらキーボードが閉じるようにする
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
//    ユーザの画像の編集
    @IBAction func image_button(_ sender: Any) {
        let ipc = UIImagePickerController()
        ipc.delegate = self
        ipc.sourceType = UIImagePickerController.SourceType.photoLibrary
        //編集を可能にする
        ipc.allowsEditing = true
        self.present(ipc,animated: true, completion: nil)
    }
    
    //写真を選択した時の処理を書く。
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //編集機能を表示させたい場合
        //UIImagePickerControllerEditedImageはallowsEditingをYESにした場合に用いる。
        //allowsEditingで指定した範囲を画像として取得する事ができる。
        //UIImagePickerControllerOriginalImageはallowsEditingをYESにしていたとしても編集機能は表示されない。
        if info[.originalImage] != nil {
            let image = info[.originalImage] as! UIImage
            //画像を設定する
            user_image.image = image
            self.user_image.layer.cornerRadius = 60
            self.user_image.layer.masksToBounds = true
            
            //    firebaseのデータベース取得
            var ref: DatabaseReference!
            ref = Database.database().reference()
            //firebaseデータベースにuser追加
            let user = Auth.auth().currentUser
            let user_id = user?.uid
//            ref.child("users/\(user_id!)").updateChildValues(["user_image": user_image.image!])
            
            // PNG形式の画像フォーマットとしてNSDataに変換
            let image_data = user_image.image!.pngData()
            
            //画像をNSDataにキャスト
            let data:NSData = image_data as! NSData
            
            //BASE64のStringに変換する
            let encodeString:String =
                data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)

            ref.child("users/\(user_id!)").updateChildValues(["user_image": encodeString])
            
            
        }
        
        //編集機能を表示させない場合
        //let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //imageView.image = image
        
        dismiss(animated: true,completion: nil)
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
