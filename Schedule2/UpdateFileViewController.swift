//
//  UpdateFileViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/02/18.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit

class UpdateFileViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var recieve_class_name: String = ""
    var recieve_indexPath: String = ""
    var recieve_image_list: Array<UIImage> = []
    
    @IBOutlet weak var albumName: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("aaaaaaaaaaaaaaaaaaaa")
        print(recieve_image_list)
        self.collectionView.delegate = self as! UICollectionViewDelegate
        self.collectionView.dataSource = self as! UICollectionViewDataSource
        // Do any additional setup after loading the view.
    }
    
//    @IBAction func UpdateFileButton(_ sender: Any) {
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        let daigaku = UserDefaults.standard.string(forKey: "daigaku")
//        let gakubu = UserDefaults.standard.string(forKey: "gakubu")
//        ref.child("classes/\(daigaku!)/\(gakubu!)/\(self.receive_indexPath)/\(self.recieve_class_name)").updateChildValues(["indexPath": receive_indexPath, "class_name": class_name, "room_name": room_name])
//    }
    
    @IBAction func cancelButton(_ sender: Any) {
        back_to_classView()
    }
    
    func back_to_classView() {
        //まずは、同じstororyboard内であることをここで定義します
        let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択
        let timeschedule = storyboard.instantiateViewController(withIdentifier: "ClassView")
        //ここが実際に移動するコードとなります
        self.present(timeschedule, animated: true, completion: nil)
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

extension UpdateFileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // スタンプが押された時の処理を書く
    }
}

extension UpdateFileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.recieve_image_list.count)
        return self.recieve_image_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("bbbbbbbbbbbbb")
        print(recieve_image_list[indexPath.row])
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image_cell", for: indexPath)
        if let image = cell.contentView.viewWithTag(1) as? UIImageView {
            print("ccccccccccccccccccc")
            image.image = recieve_image_list[indexPath.row]
        }
        
        return cell
    }
}
