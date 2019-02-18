//
//  UpdateFileViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/02/18.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit

class UpdateFileViewController: UIViewController {
    
    var recieve_class_name: String = ""
    var recieve_indexPath: String = ""
    var recieve_image_list: Array<UIImage> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("aaaaaaaaaaaaa")
        print(recieve_indexPath)
        print(recieve_class_name)
        print(recieve_image_list)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func UpdateFileButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
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
