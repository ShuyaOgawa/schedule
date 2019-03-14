//
//  image_detailViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/03/15.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit

class image_detailViewController: UIViewController {
    
    var recieve_touch_image: UIImage?
    var recieve_image_list: Array<UIImage> = []
    
    // ScrollScreenの高さ
    var scrollScreenHeight:CGFloat!
    // ScrollScreenの幅
    var scrollScreenWidth:CGFloat!
    
    var pageNum:Int!
    
    var imageWidth:CGFloat!
    var imageHeight:CGFloat!
    var screenSize:CGRect!

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var scrView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 下向きにスワイプした時のジェスチャーを作成
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.closeModalView))
        downSwipeGesture.direction = .down
        
        // 画面にジェスチャーを登録
        view.addGestureRecognizer(downSwipeGesture)
        
        
        screenSize = UIScreen.main.bounds
        
        // ページスクロールとするためにページ幅を合わせる
        scrollScreenWidth = screenSize.width
        
        let imageTop:UIImage = recieve_touch_image!
        pageNum = recieve_image_list.count
        
        imageWidth = imageTop.size.width
        imageHeight = imageTop.size.height
        scrollScreenHeight = scrollScreenWidth * imageHeight/imageWidth
        
        for i in 0 ..< pageNum {
            // UIImageViewのインスタンス
            let image:UIImage = recieve_image_list[i]
            let imageView = UIImageView(image:image)
            
            var rect:CGRect = imageView.frame
            rect.size.height = scrollScreenHeight
            rect.size.width = scrollScreenWidth
            
            imageView.frame = rect
            imageView.tag = i + 1
            
            // UIScrollViewのインスタンスに画像を貼付ける
            self.scrView.addSubview(imageView)
            
        }
        
        setupScrollImages()
        
    }
    
    func setupScrollImages(){
        
        // ダミー画像
        let imageDummy:UIImage = recieve_touch_image!
        var imgView = UIImageView(image:imageDummy)
        var subviews:Array = scrView.subviews
        
        // 描画開始の x,y 位置
        var px:CGFloat = 0.0
        let py:CGFloat = (screenSize.height - scrollScreenHeight)/2
        
        for i in 0 ..< subviews.count {
            imgView = subviews[i] as! UIImageView
            if (imgView.isKind(of: UIImageView.self) && imgView.tag > 0){
                
                var viewFrame:CGRect = imgView.frame
                viewFrame.origin = CGPoint(x: px, y: py)
                imgView.frame = viewFrame
                
                px += (scrollScreenWidth)
                
            }
        }
        // UIScrollViewのコンテンツサイズを画像のtotalサイズに合わせる
        let nWidth:CGFloat = scrollScreenWidth * CGFloat(pageNum)
        scrView.contentSize = CGSize(width: nWidth, height: scrollScreenHeight)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // 画面を閉じる
    @objc func closeModalView() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
