//
//  gakubuEditViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/01/29.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class gakubuEditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    var pickerView: UIPickerView = UIPickerView()
    
    var recieve_daigaku = ""
    
    var return_cell_number: Int = 1
    
    var return_gakubu_array: Array<Any> = []
    
    @IBOutlet weak var gakubu_picker: UITextField!
    
    
    let rika_gakubu_array = ["理学部第一部","理学部第二部","工学部","薬学部","理工学部","基礎工学部","経営学部"]
    let aogaku_gakubu_array = ["文学部","教育人間科学部","経済学部","法学部","経営学部","国際政治経済学部","総合文化政策学部","理工学部","社会情報学部","地球社会共生学部","コミュニティ人間科学部"]
    let hosei_gakubu_array = ["法学部","文学部","経済学部","社会学部","経営学部","国際文化学部","人間環境学部","現代福祉学部","キャリアデザイン学部","グローバル教養学部","スポーツ健康学部","情報科学部","デザイン工学部","理工学部","生命科学部"]
    let meiji_gakubu_array = ["法学部","商学部","政治経済学部","文学部","経営学部","情報コミュニケーション学部","国際日本学部","理工学部","農学部","総合数理学部"]
    let rikkyo_gakubu_array = ["文化学部","異文化コミュニケーション学部","経済学部","経営学部","理学部","社会学部","法学部","観光学部","コミュニティ福祉学部","現代心理学部","Global Liberal Arts Program"]
    let chuo_gakubu_array = ["法学部","経済学部","商学部","理工学部","文学部","総合政策学部","国際経営学部","国際情報学部"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(daigakuEditViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(daigakuEditViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        self.gakubu_picker.inputView = pickerView
        self.gakubu_picker.inputAccessoryView = toolbar
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.recieve_daigaku == "明治大学" {
            self.return_cell_number = meiji_gakubu_array.count
        } else if self.recieve_daigaku == "青山学院大学" {
            self.return_cell_number = aogaku_gakubu_array.count
        } else if self.recieve_daigaku == "立教大学" {
            self.return_cell_number = hosei_gakubu_array.count
        } else if self.recieve_daigaku == "中央大学" {
            self.return_cell_number = chuo_gakubu_array.count
        } else if self.recieve_daigaku == "法政大学" {
            self.return_cell_number = hosei_gakubu_array.count
        } else if self.recieve_daigaku == "東京理科大学" {
            self.return_cell_number = rika_gakubu_array.count
        }
        return self.return_cell_number
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.recieve_daigaku == "明治大学" {
            self.return_gakubu_array = meiji_gakubu_array
        } else if self.recieve_daigaku == "青山学院大学" {
            self.return_gakubu_array = aogaku_gakubu_array
        } else if self.recieve_daigaku == "立教大学" {
            self.return_gakubu_array = hosei_gakubu_array
        } else if self.recieve_daigaku == "中央大学" {
            self.return_gakubu_array = chuo_gakubu_array
        } else if self.recieve_daigaku == "法政大学" {
            self.return_gakubu_array = hosei_gakubu_array
        } else if self.recieve_daigaku == "東京理科大学" {
            self.return_gakubu_array = rika_gakubu_array
        }
        return self.return_gakubu_array[row] as! String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.recieve_daigaku == "明治大学" {
            self.gakubu_picker.text = meiji_gakubu_array[row]
        } else if self.recieve_daigaku == "青山学院大学" {
            self.gakubu_picker.text = aogaku_gakubu_array[row]
        } else if self.recieve_daigaku == "立教大学" {
            self.gakubu_picker.text = hosei_gakubu_array[row]
        } else if self.recieve_daigaku == "中央大学" {
            self.gakubu_picker.text = chuo_gakubu_array[row]
        } else if self.recieve_daigaku == "法政大学" {
            self.gakubu_picker.text = hosei_gakubu_array[row]
        } else if self.recieve_daigaku == "東京理科大学" {
            self.gakubu_picker.text = rika_gakubu_array[row]
        }
        
    }
    
    @objc func cancel() {
        self.gakubu_picker.text = ""
        self.gakubu_picker.endEditing(true)
    }
    
    @objc func done() {
        self.gakubu_picker.endEditing(true)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func updata_gakubu_button(_ sender: Any) {
        if self.gakubu_picker.text != "" {
//                firebaseのデータベース取得
            var ref: DatabaseReference!
            ref = Database.database().reference()
            //firebaseデータベースにuser追加
            let user = Auth.auth().currentUser
            let user_id = user?.uid
            let gakubu = self.gakubu_picker.text
            ref.child("users/\(user_id!)").updateChildValues(["gakubu": gakubu!])
            //        学部をUserDefaultに書き込み
            UserDefaults.standard.set(gakubu, forKey: "gakubu")
//            not_daigaku_registerを初期化
            let not_daigaku_register: Array = ["",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "", ""]
            UserDefaults.standard.set(not_daigaku_register, forKey: "not_daigaku_register")
            //まずは、同じstororyboard内であることをここで定義します
            let storyboard: UIStoryboard = self.storyboard!
            //ここで移動先のstoryboardを選択
            let AccountView = storyboard.instantiateViewController(withIdentifier: "AccountView")
            //ここが実際に移動するコードとなります
            self.present(AccountView, animated: true, completion: nil)
        } else {
            let alert: UIAlertController = UIAlertController(title: "保存できません", message: "学部名を選択してください。", preferredStyle:  UIAlertController.Style.alert)
            
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
            })
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    

}
