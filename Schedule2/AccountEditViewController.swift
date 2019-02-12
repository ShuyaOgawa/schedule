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
//            var ref: DatabaseReference!
//            ref = Database.database().reference()
            //firebaseデータベースにuser追加
            let user = Auth.auth().currentUser
            let user_id = user?.uid
//            ref.child("users/\(user_id!)").updateChildValues(["user_image": user_image.image!])
            
            // PNG形式の画像フォーマットとしてNSDataに変換
//            let image_data = user_image.image!.pngData()
            
            //画像をNSDataにキャスト
//            let data:NSData = image_data as! NSData
            
            //BASE64のStringに変換する
//            let encodeString:String =
//                data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
//            ref.child("users/\(user_id!)").updateChildValues(["user_image": encodeString])
            
            
//            ストレージにトプ画の保存
            let storage = Storage.storage()
            let storageRef = storage.reference(forURL: "gs://schedule-7b17a.appspot.com")
//            if let data = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage).pngData() {
            
                
//                画像圧縮
            let arrangedImage = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage).fixedOrientation()?.resizeImage(maxSize: 1048576)
            if let data = arrangedImage!.pngData() {
                
                
                
                //user_uidの名前で画像保存
                let reference = storageRef.child("user_image/" + user_id! + ".jpg")
                reference.putData(data, metadata: nil, completion: { metaData, error in
                })
            }
            
        }
        
        //編集機能を表示させない場合
        //let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //imageView.image = image
        
        dismiss(animated: true,completion: nil)
    }
    
}


extension UIImage {
    
    /// 上下逆になった画像を反転する
    func fixedOrientation() -> UIImage? {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// イメージ縮小
    func resizeImage(maxSize: Int) -> UIImage? {
        
        guard let jpg = self.jpegData(compressionQuality: 1) as NSData? else {
            return nil
        }
        if isLessThanMaxByte(data: jpg, maxDataByte: maxSize) {
            return self
        }
        // 80%に圧縮
        let _size: CGSize = CGSize(width: (self.size.width * 0.8), height: (self.size.height * 0.8))
        UIGraphicsBeginImageContext(_size)
        self.draw(in: CGRect(x: 0, y: 0, width: _size.width, height: _size.height))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        // 再帰処理
        return newImage.resizeImage(maxSize: maxSize)
    }
    
    /// 最大容量チェック
    func isLessThanMaxByte(data: NSData?, maxDataByte: Int) -> Bool {
        
        if maxDataByte <= 0 {
            // 最大容量の指定が無い場合はOK扱い
            return true
        }
        guard let data = data else {
            fatalError("Data unwrap error")
        }
        if data.length < maxDataByte {
            // 最大容量未満：OK　※以下でも良いがバッファを取ることにした
            return true
        }
        // 最大容量以上：NG
        return false
    }
}


