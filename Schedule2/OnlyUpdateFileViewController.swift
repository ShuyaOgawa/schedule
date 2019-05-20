//
//  OnlyUpdateFileViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/05/20.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit
import Firebase
import DKImagePickerController

class OnlyUpdateFileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var classTableView: UITableView!
    
    
    
    
    let daigaku = UserDefaults.standard.string(forKey: "daigaku")
    let gakubu = UserDefaults.standard.string(forKey: "gakubu")
    
    var classList: Array<String> = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getClassesName()
    
    }
    
    
    
    func getClassesName() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("classes/\(daigaku!)/\(gakubu!)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            if value != nil {
                var classNumber = 1
                while classNumber < 36 {
                    var className = value![String(classNumber)] as? [String : Any]
                    if className != nil {
                        for (key, value) in className! {
                            self.classList.append(key)
                        }
                    }
                    
                    classNumber += 1
                    self.classTableView.reloadData()
                }
                
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "classItem", for: indexPath) as! OnlyUpdateFileTableViewCell
        
        let className = cell.contentView.viewWithTag(1) as? UILabel
        className?.text = classList[indexPath.row]
        
        return cell
    }
    
    @IBAction func backButton(_ sender: Any) {
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
