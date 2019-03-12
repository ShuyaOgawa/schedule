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
    
    
    let daigaku = UserDefaults.standard.string(forKey: "daigaku")
    let gakubu = UserDefaults.standard.string(forKey: "gakubu")
    
    
    
    @IBOutlet weak var ShowAlbumCollection: UICollectionView!
    @IBOutlet weak var album_name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        album_name.text = recieve_album_name
        get_album_number()
        
        
        
       
        
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
    

    

    
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
