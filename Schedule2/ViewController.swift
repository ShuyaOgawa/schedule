//
//  ViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2018/11/26.
//  Copyright © 2018年 Digital Circus Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func backToTop(segue: UIStoryboardSegue) {}
    @IBOutlet weak var HomeMemoTextView: UITextView!
    
    let classNameSample = ["英語", "", "発生工学", "実験", "実験", "実験", "", "", "", "", "", "", "", "", "ガンの生物学", "", "環境工学", "", "", "英語", "免疫工学", "実験", "実験", "実験", "", "", "", "実験", "実験", "実験", "", "", "", "", "", ""]
    
    let classRoomSample = ["501", "", "502", "実験室", "実験室", "実験室", "", "", "", "", "", "", "", "", "506", "", "505", "", "", "501", "502", "実験室", "実験室", "実験室", "", "", "", "実験室", "実験室", "実験室", "", "", "", "", "", ""]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 36
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleItem", for: indexPath) as! ScheduleItemCollectionViewCell
        
        cell.className.text = classNameSample[indexPath.row]
        cell.classRoom.text = classRoomSample[indexPath.row]
        
        print(cell)
      
        
        
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.7
        
        
        // 枠のカラー
        cell.classRoom.layer.borderColor = UIColor.black.cgColor
        
        // 枠の幅
        cell.classRoom.layer.borderWidth = 1.0
        
        // 枠を角丸にする場合
        cell.classRoom.layer.cornerRadius = 3.0
        cell.classRoom.layer.masksToBounds = true
        
        

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
          
            layout.itemSize = CGSize(width: collectionView.bounds.width / 6, height: collectionView.bounds.height / 6)
        }
        
        return cell
    }
    
  
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 枠のカラー
        HomeMemoTextView.layer.borderColor = UIColor.gray.cgColor
        
        // 枠の幅
        HomeMemoTextView.layer.borderWidth = 1.0
        
        // 枠を角丸にする場合
        HomeMemoTextView.layer.cornerRadius = 10.0
        HomeMemoTextView.layer.masksToBounds = true
        
        
        
      
    }


}

