//
//  AlbumContainerViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/03/05.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit

class AlbumContainerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
   

    @IBOutlet weak var albumCollection: UICollectionView!
    
    var recieve_class_name: String = ""
    var recieve_indexPath: String = ""
    var album_name_array: Array<String> = []
    var album_number: Int = 0
    var album_image_list: Array<UIImage> = []
    var album_image: UIImage?
    var give_album_name: String = ""
    
    
    private let refreshControl = UIRefreshControl()
    
    
    
    let daigaku = UserDefaults.standard.string(forKey: "daigaku")
    let gakubu = UserDefaults.standard.string(forKey: "gakubu")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if daigaku  != nil && gakubu != nil {
            get_album_number_name()
            albumCollection.refreshControl = refreshControl
            refreshControl.addTarget(self, action: #selector(AlbumContainerViewController.refresh(sender:)), for: .valueChanged)
        }
        
        
        
    }
    
    
    @objc func refresh(sender: UIRefreshControl) {
        
        sender.beginRefreshing()
        get_album_number_name()
        // データフェッチが終わったらUIRefreshControl.endRefreshing()を呼ぶ必要がある
        
        sender.endRefreshing()
    }

    
    
    //        アルバム数、名前取得
    func get_album_number_name(){
        
        self.album_name_array = []
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("classes/\(daigaku!)/\(gakubu!)/\(recieve_indexPath)/\(recieve_class_name)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as! NSDictionary
            let album = value["album"] as? NSDictionary
            if album != nil {
                self.album_number = album!.count
                for  (key, value) in album!{
                    
                    self.album_name_array.append(key as! String)
                }
            } else {
                self.album_number = 0
            }
            self.get_album_image()
            self.albumCollection.reloadData()
        })
    }
    
    
    
    
    func get_album_image(){
        
        self.album_image_list = Array(repeating: UIImage(), count: self.album_name_array.count)
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: "gs://schedule-7b17a.appspot.com")
        if self.album_name_array != [] {
            
            
            
            for album_name in self.album_name_array {
                
                let riversRef = storageRef.child("classes/\(daigaku!)/\(gakubu!)/\(recieve_class_name)/\(album_name)/0")
                riversRef.getData(maxSize: 20 * 1024 * 1024) { data, error in
                    if let error = error {
                        // Uh-oh, an error occurred!
                        print(error)
                    } else {
                        // Data for "images/island.jpg" is returned
                        let image: UIImage? = data.flatMap(UIImage.init)
//                        self.album_image_list.append(image!)
                        
                        if self.album_name_array != [] {
                            self.album_image_list[self.album_name_array.index(of: album_name)!] = image!
                            //                        self.album_image.image = image
                            //                        self.user_image.layer.cornerRadius = 40
                            //                        self.user_image.layer.masksToBounds = true
                            self.album_image = image!
                        }
                        
                    }
                    self.albumCollection.reloadData()
                }
                
            }
            
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.album_number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumItem", for: indexPath) as! AlbumContainerCollectionViewCell
      
        
        
        
        
        if self.album_name_array != [] {
            cell.album_name.text = self.album_name_array[indexPath.row]
        }
        
        
        
        
        if self.album_image != nil{
            cell.album_image.image = self.album_image_list[indexPath.row]
            cell.album_image.layer.masksToBounds = true
        }
        
        
     
       
//        cell.album_image.image = self.album_image_list[indexPath.row]

        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.give_album_name = self.album_name_array[indexPath.row]
        self.performSegue(withIdentifier: "showAlbum", sender: nil)
    }
    
    // 画面遷移先のViewControllerを取得し、データを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbum" {
            let vc = segue.destination as! ShowAlbumViewController
            vc.recieve_indexPath = self.recieve_indexPath
            vc.recieve_class_name = self.recieve_class_name
            vc.recieve_album_name = self.give_album_name
        }
    }
    

}



