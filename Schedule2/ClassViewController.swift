//
//  SecondViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2018/11/27.
//  Copyright © 2018年 Digital Circus Inc. All rights reserved.
//

import UIKit
import Firebase

class ClassViewController: UIViewController, UIImagePickerControllerDelegate{

    @IBOutlet weak var class_label: UILabel!
    
    var recieve_class_name: String = ""
    
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
        let pickerController = UIImagePickerController()
        // 選択可能上限の設定もできます
        pickerController.maxSelectableCount = 5
        pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
            // 選択された画像はassetsに入れて返却されますのでfetchして取り出すとよいでしょう
            for asset in assets {
                asset.fetchFullScreenImage(true, completeBlock: { (image, info) in
                    // ここで取り出せます
                })
            }
        }
        self.present(pickerController, animated: true) {}
    }
    
    

}

