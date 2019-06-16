//
//  UpdateFileViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/02/18.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit

class UpdateFileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var recieve_class_name: String = ""
    var recieve_indexPath: String = ""
    var recieve_image_list: Array<UIImage> = []
    
    
    var ActivityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var albumName: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        albumName.delegate = self
        
        self.collectionView.delegate = self as! UICollectionViewDelegate
        self.collectionView.dataSource = self as! UICollectionViewDataSource
        
        
        
        // ActivityIndicatorを作成＆中央に配置
        ActivityIndicator = UIActivityIndicatorView()
        ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        ActivityIndicator.center = self.view.center
        
        // クルクルをストップした時に非表示する
        ActivityIndicator.hidesWhenStopped = true
        
        // 色を設定
        ActivityIndicator.style = UIActivityIndicatorView.Style.gray
        
        //Viewに追加
        self.view.addSubview(ActivityIndicator)
        
        
        
        
        
        
    }
    
//    @IBAction func UpdateFileButton(_ sender: Any) {
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        let daigaku = UserDefaults.standard.string(forKey: "daigaku")
//        let gakubu = UserDefaults.standard.string(forKey: "gakubu")
//        ref.child("classes/\(daigaku!)/\(gakubu!)/\(self.receive_indexPath)/\(self.recieve_class_name)").updateChildValues(["indexPath": receive_indexPath, "class_name": class_name, "room_name": room_name])
//    }
    
    //Enterを押したらキーボードが閉じるようにする
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func back_to_classView() {
        //まずは、同じstororyboard内であることをここで定義します
        let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択
        let timeschedule = storyboard.instantiateViewController(withIdentifier: "ClassView")
        //ここが実際に移動するコードとなります
        self.present(timeschedule, animated: true, completion: nil)
    }
    
    @IBAction func upload_file_button(_ sender: Any) {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
//        キーボードとじる
        albumName.endEditing(true)
        
        let daigaku = UserDefaults.standard.string(forKey: "daigaku")
        let gakubu = UserDefaults.standard.string(forKey: "gakubu")
        
        let album_name = albumName.text
//        アルバム名が入力されていなかったらエラー
        if album_name! == "" {
            let alert: UIAlertController = UIAlertController(title: "保存できません", message: "アルバム名を選択してください。", preferredStyle:  UIAlertController.Style.alert)
            
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
            })
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        } else {
//            くるくるスタート
            ActivityIndicator.startAnimating()
            //        アルバム名取得
//            ref.child("classes/\(daigaku!)/\(gakubu!)/\(recieve_indexPath)/\(recieve_class_name)").observeSingleEvent(of: .value, with: { (snapshot) in
            ref.child("classes/\(daigaku!)/\(gakubu!)/\(recieve_class_name)").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                print("aaaaaaaaaaaa")
                print(self.recieve_indexPath)
                print(self.recieve_class_name)
                let value = snapshot.value as! NSDictionary
                var album = value["album"] as? [String : Any]
                if album != nil {
                    for (key, value) in album! {
                        //        既にあるアルバム名ならエラー
                        if key == album_name {
                            let alert: UIAlertController = UIAlertController(title: "保存できません", message: "既に同じ名前のアルバムがあります。", preferredStyle:  UIAlertController.Style.alert)
                            
                            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                                // ボタンが押された時の処理を書く（クロージャ実装）
                                (action: UIAlertAction!) -> Void in
                            })
                            alert.addAction(defaultAction)
                            self.present(alert, animated: true, completion: nil)
                            
                            
                        } else if key != album_name && album!.count == 1 {
                            
                            
                            //保存するURLを指定
                            let storage = Storage.storage()
                            let storageRef = storage.reference(forURL: "gs://schedule-7b17a.appspot.com")
                            //保存を実行して、metadataにURLが含まれているので、あとはよしなに加工
                            for image in self.recieve_image_list {
                                let data = image.pngData()
                                //ディレクトリを指定
                                let index_image = self.recieve_image_list.index(of: image)
                                let reference = storageRef.child("classes/\(daigaku!)/\(gakubu!)/\(self.recieve_class_name)").child(album_name!).child(String(index_image!))
                                reference.putData(data!, metadata: nil, completion: { metaData, error in
                                    print("done")
                                    self.ActivityIndicator.stopAnimating()
                                    self.dismiss(animated: true)
                                    
                                    
                                    
                                    
                                })
                            }
                            //                保存するアルバム名等をrealtimedatabaseにも追加する
                            let user = Auth.auth().currentUser
                            let user_id = user?.uid
//                            ref.child("classes/\(daigaku!)/\(gakubu!)/\(self.recieve_indexPath)/\(self.recieve_class_name)/album/\(album_name!)").updateChildValues(["albumName": album_name!, "user": user_id!, "imageNumber": String(self.recieve_image_list.count)])
                            ref.child("classes/\(daigaku!)/\(gakubu!)/\(self.recieve_class_name)/album/\(album_name!)").updateChildValues(["albumName": album_name!, "user": user_id!, "imageNumber": String(self.recieve_image_list.count)])
                            
                            
                        }
                        album!.removeValue(forKey: key)
                    }
                    
//                    そもそもアルバムがない時
                } else {
                    //            くるくるスタート
                    self.ActivityIndicator.startAnimating()
                    //保存するURLを指定
                    let storage = Storage.storage()
                    let storageRef = storage.reference(forURL: "gs://schedule-7b17a.appspot.com")
                    //保存を実行して、metadataにURLが含まれているので、あとはよしなに加工
                    for image in self.recieve_image_list {
                        let data = image.pngData()
                        //ディレクトリを指定
                        let index_image = self.recieve_image_list.index(of: image)
                        let reference = storageRef.child("classes/\(daigaku!)/\(gakubu!)/\(self.recieve_class_name)").child(album_name!).child(String(index_image!))
                        reference.putData(data!, metadata: nil, completion: { metaData, error in
                            self.ActivityIndicator.stopAnimating()
                            self.dismiss(animated: true)
                            print("done")
                        })
                    }
                    //                保存するアルバム名等をrealtimedatabaseにも追加する
                    let user = Auth.auth().currentUser
                    let user_id = user?.uid
//                    ref.child("classes/\(daigaku!)/\(gakubu!)/\(self.recieve_indexPath)/\(self.recieve_class_name)/album/\(album_name!)").updateChildValues(["albumName": album_name!, "user": user_id!, "imageNumber": String(self.recieve_image_list.count)])
                    ref.child("classes/\(daigaku!)/\(gakubu!)/\(self.recieve_class_name)/album/\(album_name!)").updateChildValues(["albumName": album_name!, "user": user_id!, "imageNumber": String(self.recieve_image_list.count)])
                }
            })
            
            
            
            
            
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

}

extension UpdateFileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // スタンプが押された時の処理を書く
    }
}

extension UpdateFileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recieve_image_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image_cell", for: indexPath)
        if let image = cell.contentView.viewWithTag(1) as? UIImageView {
            image.image = recieve_image_list[indexPath.row]
        }
        
        return cell
    }
}
