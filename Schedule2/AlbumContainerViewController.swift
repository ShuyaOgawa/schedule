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
    var album_number: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        get_album_number()

        
    }
    
    
    //        アルバム数取得
    func get_album_number(){
        let daigaku = UserDefaults.standard.string(forKey: "daigaku")
        let gakubu = UserDefaults.standard.string(forKey: "gakubu")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("classes/\(daigaku!)/\(gakubu!)/\(recieve_indexPath)/\(recieve_class_name)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as! NSDictionary
            let album = value["album"] as? NSDictionary
            if album != nil {
                self.album_number = album!.count
            } else {
                self.album_number = 0
            }
            print("aaaaaaaaaaaa")
            print(self.album_number)
            self.albumCollection.reloadData()
        })
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        print("---------")
        print(self.album_number)
        return self.album_number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumItem", for: indexPath) as! AlbumContainerCollectionViewCell
        
        return cell
    }
    

}
