//
//  daigakuEditViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/01/29.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class daigakuEditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var daigaku: UITextField!
    
    var pickerView: UIPickerView = UIPickerView()
    var daigaku_list = ["明治大学", "青山学院大学", "立教大学", "中央大学", "法政大学", "東京理科大学"]
    
    var give_daigaku = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(daigakuEditViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(daigakuEditViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        self.daigaku.inputView = pickerView
        self.daigaku.inputAccessoryView = toolbar
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daigaku_list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return daigaku_list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.daigaku.text = daigaku_list[row]
    }
    
    @objc func cancel() {
        self.daigaku.text = ""
        self.daigaku.endEditing(true)
    }
    
    @objc func done() {
        self.daigaku.endEditing(true)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    @IBAction func goTogakubu(_ sender: Any) {
        //    firebaseのデータベース取得
        var ref: DatabaseReference!
        ref = Database.database().reference()
        //firebaseデータベースにuser追加
        let user = Auth.auth().currentUser
        let user_id = user?.uid
        let daigaku = self.daigaku.text
        ref.child("users/\(user_id!)").updateChildValues(["daigaku": daigaku!])
//        大学をUserDefaultにと書き込み
        UserDefaults.standard.set(daigaku, forKey: "daigaku")
    }
    
    // 画面遷移先のViewControllerを取得し、データを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gakubu" {
            let vc = segue.destination as! gakubuEditViewController
            let give_daigaku = self.daigaku.text
            vc.recieve_daigaku = give_daigaku!
        }
    }
    
    
    @IBAction func backToAcountView(_ sender: Any) {
        self.dismiss(animated: true)
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
