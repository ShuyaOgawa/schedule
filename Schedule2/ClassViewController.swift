//
//  SecondViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2018/11/27.
//  Copyright © 2018年 Digital Circus Inc. All rights reserved.
//

import UIKit

class ClassViewController: UIViewController {

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

}
