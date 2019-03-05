//
//  AlbumContainerViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/03/05.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit

class AlbumContainerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
   

    @IBOutlet weak var albumCollection: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 34
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumItem", for: indexPath) as! AlbumContainerCollectionViewCell
        return cell
    }
    

}
