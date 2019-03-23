//
//  ShowAlbumViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/03/11.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit

class ShowAlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    var recieve_class_name: String = ""
    var recieve_indexPath: String = ""
    var recieve_album_name: String = ""
    var number_of_album: Int = 0
    var album_image_list: Array<UIImage> = []
    var give_toucu_album_image: UIImage?
    
    
    let daigaku = UserDefaults.standard.string(forKey: "daigaku")
    let gakubu = UserDefaults.standard.string(forKey: "gakubu")
    
    
    
    @IBOutlet weak var ShowAlbumCollection: UICollectionView!
    @IBOutlet weak var album_name: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        album_name.text = recieve_album_name
        get_album_number()
        
        let user = Auth.auth().currentUser
        let user_id = user?.uid
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("classes/\(daigaku!)/\(gakubu!)/\(recieve_indexPath)/\(recieve_class_name)/album/\(recieve_album_name)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as! NSDictionary
            let update_user = value["user"] as! String
            if update_user != user_id {
                self.deleteButton.isEnabled = false
            } else {
                self.deleteButton.isEnabled = true
            }
        })
        
    }
    
    func get_album_number(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("classes/\(daigaku!)/\(gakubu!)/\(recieve_indexPath)/\(recieve_class_name)/album/\(recieve_album_name)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as! NSDictionary
            let album_number = value["imageNumber"] as! String
            self.number_of_album = Int(album_number)!
           
//            self.get_album_image()
            self.get_album_image()
            self.ShowAlbumCollection.reloadData()
        })
    }
    
    func get_album_image(){
        self.album_image_list = Array(repeating: UIImage(), count: self.number_of_album)
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: "gs://schedule-7b17a.appspot.com")
        var i: Int = 0
        while i < self.number_of_album {
            let string_i = String(i)
            let riversRef = storageRef.child("classes/\(daigaku!)/\(gakubu!)/\(recieve_class_name)/\(recieve_album_name)/\(String(i))")
            riversRef.getData(maxSize: 20 * 1024 * 1024) { data, error in
                if let error = error {
                    // Uh-oh, an error occurred!
                    print(error)
                } else {
                    // Data for "images/island.jpg" is returned
                    let image: UIImage? = data.flatMap(UIImage.init)
                    //                        self.album_image_list.append(image!)
                   
                    self.album_image_list[Int(string_i)!] = image!
                    //                        self.album_image.image = image
                    //                        self.user_image.layer.cornerRadius = 40
                    //                        self.user_image.layer.masksToBounds = true
                }
                
                self.ShowAlbumCollection.reloadData()
            }
            i += 1
        }
     
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.number_of_album
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowAlbumItem", for: indexPath) as! ShowAlbumCollectionViewCell
        
        cell.album_image.image = self.album_image_list[indexPath.row]
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.give_toucu_album_image = self.album_image_list[indexPath.row]
        self.performSegue(withIdentifier: "image_detail", sender: nil)
    }
    
    // 画面遷移先のViewControllerを取得し、データを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "image_detail" {
            let vc = segue.destination as! image_detailViewController
            vc.recieve_touch_image = self.give_toucu_album_image
            vc.recieve_image_list = self.self.album_image_list
        }
    }
    

    @IBAction func delete_button(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("classes/\(daigaku!)/\(gakubu!)/\(recieve_indexPath)/\(recieve_class_name)/album/\(recieve_album_name)").removeValue()
        
        
        for i in 0..<self.number_of_album {
            let storage = Storage.storage()
            let storageRef = storage.reference(forURL: "gs://schedule-7b17a.appspot.com")
            let desertRef = storageRef.child("classes/\(daigaku!)/\(gakubu!)/\(recieve_class_name)/\(recieve_album_name)/\(i)")
            // Delete the file
            desertRef.delete { error in
                if let error = error {
                    print("error")
                    print(error)
                } else {
                    // File deleted successfully
                    print("doneeeeeeeeeee")
                }
            }
        }
        
        self.dismiss(animated: true)
        
    }
    

    
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
