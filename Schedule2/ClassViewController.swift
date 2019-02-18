//
//  SecondViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2018/11/27.
//  Copyright © 2018年 Digital Circus Inc. All rights reserved.
//

import UIKit
import Firebase
import DKImagePickerController

class ClassViewController: UIViewController, UIImagePickerControllerDelegate{

    @IBOutlet weak var class_label: UILabel!
    
    var recieve_class_name: String = ""
    var recieve_indexPath: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        class_label.text = recieve_class_name
        // Do any additional setup after loading the view.
        
        
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func upload_file(_ sender: Any) {
        var image_list: Array<UIImage> = []
        let pickerController = DKImagePickerController()
        pickerController.showsCancelButton = true
        // 選択可能上限の設定もできます
        pickerController.maxSelectableCount = 30
        pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
            // 選択された画像はassetsに入れて返却されますのでfetchして取り出すとよいでしょう
            for asset in assets {
                asset.fetchFullScreenImage(completeBlock: { (image, info) in
                    // ここで取り出せます
                    image_list.append(image!)
                    print("aaaaaaaaaaaaaaaaaaaa")
                    print(image_list)
                    self.go_to_UpdateFileViewController()
                })
            }
        }
        self.present(pickerController, animated: true) {}
        print(image_list)
    }
    
//    UpdateFileViewコントローラに授業名、indexPathを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "new_class" {
            let vc = segue.destination as! new_class_ViewController
            vc.receive_indexPath = give_indexPath
            vc.receive_day = give_day
        }
        if segue.identifier == "detail_class" {
            let vc = segue.destination as! ClassViewController
            vc.recieve_indexPath = give_indexPath
            vc.recieve_class_name = give_class_name
        }
    }
    
//    UpdateFileViewコントローラへの遷移メソッド
    func go_to_UpdateFileViewController() {
        let storyboard: UIStoryboard = self.storyboard!
        let login = storyboard.instantiateViewController(withIdentifier: "UpdateFileView")
        self.present(login, animated: true, completion: nil)
    }
    
    @IBAction func delete_class_button(_ sender: Any) {
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert: UIAlertController = UIAlertController(title: "削除", message: "この授業をコマから外しますか？", preferredStyle:  UIAlertController.Style.alert)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            //        UserDefaiultsのuser_id、class_name、room_name削除
            var class_array = UserDefaults.standard.array(forKey: "class_name") as! Array<String>
            class_array[Int(self.recieve_indexPath)!] = ""
            UserDefaults.standard.set(class_array, forKey: "class_name")
            var room_array = UserDefaults.standard.array(forKey: "room_name") as! Array<String>
            room_array[Int(self.recieve_indexPath)!] = ""
            UserDefaults.standard.set(class_array, forKey: "room_name")
            self.go_to_timeScheduleViewController()
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
    
//    viewControllerに遷移するメソッド
    func go_to_timeScheduleViewController() {
        let storyboard: UIStoryboard = self.storyboard!
        let login = storyboard.instantiateViewController(withIdentifier: "timeschedule")
        self.present(login, animated: true, completion: nil)
    }
    

    
}

