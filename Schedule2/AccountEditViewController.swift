//
//  AccountEditViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/01/29.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit

class AccountEditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var daigaku: UITextField!
    @IBOutlet weak var gakubu: UITextField!
    @IBOutlet weak var gakka: UITextField!
    
    var pickerView: UIPickerView = UIPickerView()
    var daigaku_list = ["明治大学", "青山学院大学", "立教大学", "中央大学", "法政大学", "上智大学", "東京理科大学"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(AccountEditViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(AccountEditViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        self.daigaku.inputView = pickerView
        self.daigaku.inputAccessoryView = toolbar
    }
    
    @IBAction func backToAcountview(_ sender: Any) {
        self.dismiss(animated: true)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
