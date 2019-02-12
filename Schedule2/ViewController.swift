//
//  ViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2018/11/26.
//  Copyright © 2018年 Digital Circus Inc. All rights reserved.
//

import UIKit
import FacebookLogin
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func backToTop(segue: UIStoryboardSegue) {}
    @IBOutlet weak var HomeMemoTextView: UITextView!
    
    // 画面遷移先に渡すindexPath
    var daigaku: String?
    var gakubu: String?
    var give_indexPath: String = ""
    var give_day: String = ""
    var give_class_name: String = ""
    var class_array: Array = ["",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "", ""]
    var room_array: Array = ["",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "", ""]
    
    
    let classNameSample = ["英語", "", "発生工学", "実験", "実験", "実験", "", "", "", "", "", "", "", "", "ガンの生物学", "", "環境工学", "", "", "英語", "免疫工学", "実験", "実験", "実験", "", "", "", "実験", "実験", "実験", "", "", "", "", "", ""]
    
    let classRoomSample = ["501", "", "502", "実験室", "実験室", "実験室", "", "", "", "", "", "", "", "", "506", "", "505", "", "", "501", "502", "実験室", "実験室", "実験室", "", "", "", "実験室", "実験室", "実験室", "", "", "", "", "", ""]
    
    let set_class_comma = ["月曜1限", "火曜1限", "水曜1限", "木曜1限", "金曜1限", "土曜1限",
                           "月曜2限", "火曜2限", "水曜2限", "木曜2限", "金曜2限", "土曜2限",
                           "月曜3限", "火曜3限", "水曜3限", "木曜3限", "金曜3限", "土曜3限",
                           "月曜4限", "火曜4限", "水曜4限", "木曜4限", "金曜4限", "土曜4限",
                           "月曜5限", "火曜5限", "水曜5限", "木曜5限", "金曜5限", "土曜5限",
                           "月曜6限", "火曜6限", "水曜6限", "木曜6限", "金曜6限", "土曜6限",
                           ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // 枠のカラー
        HomeMemoTextView.layer.borderColor = UIColor.gray.cgColor
        
        // 枠の幅
        HomeMemoTextView.layer.borderWidth = 1.0
        
        // 枠を角丸にする場合
        HomeMemoTextView.layer.cornerRadius = 10.0
        HomeMemoTextView.layer.masksToBounds = true
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let user_id = user?.uid
        
        //大学学部参照
        ref.child("users/\(user_id!)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            if value != nil {
                self.daigaku = value?["daigaku"] as? String
                self.gakubu = value?["gakubu"] as? String
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 36
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleItem", for: indexPath) as! ScheduleItemCollectionViewCell
        
        
        let provisional_indexPath = indexPath.row
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("classes/\(indexPath.row)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            if value != nil {
                let class_name = value!["class_name"] as! String
                let room_name = value!["room_name"] as! String
                var indexPath = value!["indexPath"] as! String
                if class_name != nil && room_name != nil {
                    self.class_array[provisional_indexPath] = class_name
                    self.room_array[provisional_indexPath] = room_name
                } else {
                }
            }
            cell.className.text = self.class_array[indexPath.row]
            cell.classRoom.text = self.room_array[indexPath.row]
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        cell.className.backgroundColor = UIColor.init(red: 230/255, green: 255/255, blue: 255/255, alpha: 100/100)
        
      
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.7
        
        
        // 枠のカラー
        cell.classRoom.layer.borderColor = UIColor.black.cgColor
        
        // 枠の幅
        cell.classRoom.layer.borderWidth = 1.0
        
        // 枠を角丸にする場合
        cell.classRoom.layer.cornerRadius = 3.0
        cell.classRoom.layer.masksToBounds = true
        
//        授業配置
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        ref.child("classes/0").observeSingleEvent(of: .value, with: { (snapshot) in
//             Get user value
//            let value = snapshot.value as? NSDictionary
//            let class_name = value?["class_name"] as? String?
//            let room_name = value?["room_name"] as? String?
//            if class_name != nil && room_name != nil {
//                cell.className.backgroundColor = UIColor.init(red: 230/255, green: 255/255, blue: 255/255, alpha: 95/100)
//                cell.className.text = class_name!
//                cell.classRoom.text = room_name!
//            } else {
        
//            }
        
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
     
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
          
            layout.itemSize = CGSize(width: collectionView.bounds.width / 6, height: collectionView.bounds.height / 6)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        ref.child("classes/mon_1").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let class_name = value?["class_name"] as? String?
//            let room_name = value?["room_name"] as? String?
//            if class_name! != nil && room_name! != nil {
//                self.performSegue(withIdentifier: "detail_class", sender: nil)
//            } else {
//                self.give_indexPath = String(indexPath.row)
//                self.give_day = self.set_class_comma[indexPath.row]
//                self.performSegue(withIdentifier: "new_class", sender: nil)
        
//            }
        
            
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        let provisional_indexPath = indexPath.row
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("classes/\(indexPath.row)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            if value != nil {
                let class_name = value!["class_name"] as! String
                let room_name = value!["room_name"] as! String
                self.give_class_name = class_name
                self.performSegue(withIdentifier: "detail_class", sender: nil)
            } else {
                self.give_indexPath = String(provisional_indexPath)
                self.give_day = self.set_class_comma[provisional_indexPath]
                self.performSegue(withIdentifier: "new_class", sender: nil)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    // 画面遷移先のViewControllerを取得し、データを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "new_class" {
            let vc = segue.destination as! new_class_ViewController
            vc.receive_indexPath = give_indexPath
            vc.receive_day = give_day
        }
        if segue.identifier == "detail_class" {
            let vc = segue.destination as! ClassViewController
            vc.recieve_class_name = give_class_name
        }
    }

    

}

