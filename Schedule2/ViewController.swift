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
    var give_indexPath: String = ""
    var give_day: String = ""
    var give_class_name: String = ""
    
//    var class_array: Array = ["",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "", ""]
    
    
//    var room_array: Array = ["",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "", ""]
    
    var class_array = UserDefaults.standard.array(forKey: "class_name") as! Array<String>
    var room_array = UserDefaults.standard.array(forKey: "room_name") as! Array<String>
    
    let set_class_comma = ["月曜1限", "火曜1限", "水曜1限", "木曜1限", "金曜1限", "土曜1限",
                           "月曜2限", "火曜2限", "水曜2限", "木曜2限", "金曜2限", "土曜2限",
                           "月曜3限", "火曜3限", "水曜3限", "木曜3限", "金曜3限", "土曜3限",
                           "月曜4限", "火曜4限", "水曜4限", "木曜4限", "金曜4限", "土曜4限",
                           "月曜5限", "火曜5限", "水曜5限", "木曜5限", "金曜5限", "土曜5限",
                           "月曜6限", "火曜6限", "水曜6限", "木曜6限", "金曜6限", "土曜6限",
                           ]
    
    let orange = UIColor.init(red:1.0, green:0.5, blue:0.0, alpha: 50/100)
    let green = UIColor.init(red: 0/255, green: 255/255, blue: 50/255, alpha: 30/100)
    let blue = UIColor.init(red: 0.5, green: 0.8, blue: 1.0, alpha:150/255)
    
    var colorArray: Array? = []
    var countColor: Int = 0
    
    
    
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
        
        
        makeColorArray()
        
    }
    
    func makeColorArray(){
        colorArray!.append(orange)
        colorArray!.append(green)
        colorArray!.append(blue)
    }
    
    
    
    // Long Press イベント
    @objc func longPress(_ sender: UILongPressGestureRecognizer){
        if sender.state == .began {
            // 開始は認知される
            print("LongPress began")
           
            
        } else if sender.state == .ended {
            print("Long Pressed !")
        }
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleItem", for: indexPath) as! ScheduleItemCollectionViewCell
        
        
        
        
        
        
        
        // ロングプレス
        let longPressGesture =
            UILongPressGestureRecognizer(target: self,
                                         action: #selector(self.longPress(_:)))
        // Viewに追加.
        self.view.addGestureRecognizer(longPressGesture)
        
        
        
        
        
        
        
        
        
        
        
        
        
//        let provisional_indexPath = indexPath.row
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        ref.child("classes/\(indexPath.row)").observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            if value != nil {
//                let class_name = value!["class_name"] as! String
//                let room_name = value!["room_name"] as! String
//                var indexPath = value!["indexPath"] as! String
//                if class_name != nil && room_name != nil {
//                    self.class_array[provisional_indexPath] = class_name
//                    self.room_array[provisional_indexPath] = room_name
//                } else {
//                }
//            }
//            cell.className.text = self.class_array[indexPath.row]
//            cell.classRoom.text = self.room_array[indexPath.row]
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
        cell.className.text = self.class_array[indexPath.row]
        cell.classRoom.text = self.room_array[indexPath.row]
        
        
        
//        cell.className.backgroundColor = UIColor.init(red: 230/255, green: 255/255, blue: 255/255, alpha: 100/100)
        
//        if self.class_array[indexPath.row] != "" {
//            cell.backgroundColor = UIColor.init(red: 230/255, green: 255/255, blue: 255/255, alpha: 100/100)
//        }
        
      
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.3
        
        
//        // 枠のカラー
//        cell.classRoom.layer.borderColor = UIColor.black.cgColor
//        
//        // 枠の幅
//        cell.classRoom.layer.borderWidth = 1.0
//        
//        // 枠を角丸にする場合
//        cell.classRoom.layer.cornerRadius = 3.0
//        cell.classRoom.layer.masksToBounds = true
        
        
        
//        cell.itemFolder.layer.borderColor = UIColor.black.cgColor
//        cell.itemFolder.layer.borderWidth = 1
//        cell.className.layer.borderColor = UIColor.white.cgColor
        
        if self.class_array[indexPath.row] != "" {
//            cell.itemFolder.backgroundColor = UIColor.init(red: 230/255, green: 255/255, blue: 255/255, alpha: 100/100)
            cell.itemFolder.backgroundColor = blue
            
//            cell.itemFolder.layer.cornerRadius = 10
            cell.itemFolder.layer.borderColor = UIColor.gray.cgColor
            cell.itemFolder.layer.borderWidth = 0.3
        }
        
        
        
        
        
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
//        DBに授業がある場合はclassViewContorllerに遷移、ない場合はnewClassviewControllerに遷移
//        let provisional_indexPath = indexPath.row
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        ref.child("classes/\(indexPath.row)").observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            if value != nil {
//                let class_name = value!["class_name"] as! String
//                let room_name = value!["room_name"] as! String
//                self.give_class_name = class_name
//                self.performSegue(withIdentifier: "detail_class", sender: nil)
//            } else {
//                self.give_indexPath = String(provisional_indexPath)
//                self.give_day = self.set_class_comma[provisional_indexPath]
//                self.performSegue(withIdentifier: "new_class", sender: nil)
//            }
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
//userDefaultにタッチされた授業がない場合はnewClassViewController、ある場合はclassViewControllerに遷移
        var class_array = UserDefaults.standard.array(forKey: "class_name") as! Array<String>
        if class_array[indexPath.row] != "" {
            self.give_indexPath = String(indexPath.row)
            self.give_class_name = class_array[indexPath.row]
            self.performSegue(withIdentifier: "detail_class", sender: nil)
        } else {
            self.give_indexPath = String(indexPath.row)
            self.give_day = self.set_class_comma[indexPath.row]
//            self.performSegue(withIdentifier: "new_class", sender: nil)
            self.performSegue(withIdentifier: "select_class", sender: nil)
        }
        
        
        
    }
    
    // 画面遷移先のViewControllerを取得し、データを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "new_class" {
//            let vc = segue.destination as! new_class_ViewController
//            vc.receive_indexPath = give_indexPath
//            vc.receive_day = give_day
//        }
        if segue.identifier == "detail_class" {
            let vc = segue.destination as! ClassViewController
            vc.recieve_indexPath = give_indexPath
            vc.recieve_class_name = give_class_name
        }
        if segue.identifier == "select_class" {
            let vc = segue.destination as! SelectClassViewController
            print("vvvvvvvvvvvvvvvvvv")
            print(give_indexPath)
            vc.receive_indexPath = give_indexPath
            vc.receive_day = give_day
        }
        
    }

    

}

