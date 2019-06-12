//
//  image_detailViewController.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/03/15.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import UIKit

class image_detailViewController: UIViewController, UIScrollViewDelegate {
    
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
        
        
        
        
//        // ピンチを定義
//        //let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(PinchCodeViewController.pinchView(_:)))  //Swift2.2以前
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchView))  //Swift3
//        // viewにピンチを登録
//        self.view.addGestureRecognizer(pinchGesture)
        
        print("fffffffffffffffffff")
        self.scrView.delegate = self
        let doubleTapGesture = UITapGestureRecognizer(target: self, action:#selector(self.doubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTapGesture)
        
        
        
        
        
//        変更使用
        screenSize = UIScreen.main.bounds
        pageNum = recieve_image_list.count
        let imageTop:UIImage = recieve_touch_image!
        imageWidth = imageTop.size.width
        imageHeight = imageTop.size.height
        // ページスクロールとするためにページ幅を合わせる
        scrollScreenWidth = screenSize.width
        scrollScreenHeight = scrollScreenWidth * imageHeight/imageWidth
        
        for i in 0 ..< pageNum {
            // UIImageViewのインスタンス
            let image:UIImage = recieve_image_list[i]
            let imageView = UIImageView(image:image)
            
            var rect:CGRect = imageView.frame
            //            rect.size.height = scrollScreenHeight
            rect.size.width = scrollScreenWidth
            rect.size.height = scrollScreenHeight
            
            imageView.frame = rect
            imageView.tag = i + 1
            
            // UIScrollViewのインスタンスに画像を貼付ける
            self.scrView.addSubview(imageView)
            
        }
        
        setupScrollImages()
        
 
        
////        デフォルト使用
//        screenSize = UIScreen.main.bounds
//        pageNum = recieve_image_list.count
//        let imageTop:UIImage = recieve_touch_image!
//        imageWidth = imageTop.size.width
//        imageHeight = imageTop.size.height
//        // ページスクロールとするためにページ幅を合わせる
//        scrollScreenWidth = screenSize.width
//        scrollScreenHeight = scrollScreenWidth * imageHeight/imageWidth
//
//        for i in 0 ..< pageNum {
//            // UIImageViewのインスタンス
//            let image:UIImage = recieve_image_list[i]
//            let imageView = UIImageView(image:image)
//
//            var rect:CGRect = imageView.frame
////            rect.size.height = scrollScreenHeight
//            rect.size.width = scrollScreenWidth
//            rect.size.height = scrollScreenHeight
//
//            imageView.frame = rect
//            imageView.tag = i + 1
//
//            // UIScrollViewのインスタンスに画像を貼付ける
//            self.scrView.addSubview(imageView)
//
//        }
//
//        setupScrollImages()
        
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
        
        
        
//       タップされた画像を初期値にする
        let tap_image_x: Int = (recieve_image_list.index(of: recieve_touch_image!))!*(Int(scrollScreenWidth)-1)
        scrView.contentOffset = CGPoint(x: tap_image_x, y: 0)
        
        
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // 画面を閉じる
    @objc func closeModalView() {
        dismiss(animated: true, completion: nil)
    }
    
//    /// ピンチイン・ピンチアウト時に実行される
//    @objc func pinchView(sender: UIPinchGestureRecognizer) {
//        print("pinch")
//        // ピンチイン・ピンチアウトの拡大縮小率
//        print("scale: \(sender.scale)")
//        // 1秒あたりのピンチの速度(read-only)
//        print("velocity: \(sender.velocity)")
//    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print("pinch")
        return self.image
    }
    
    @objc func doubleTap(gesture: UITapGestureRecognizer) -> Void {
        print("aaaaaaaaaaaaaaaaa")
        print(self.scrView.zoomScale)
        if (self.scrView.zoomScale < self.scrView.maximumZoomScale) {
            let newScale = self.scrView.zoomScale * 3
            let zoomRect = self.zoomRectForScale(scale: newScale, center: gesture.location(in: gesture.view))
            self.scrView.zoom(to: zoomRect, animated: true)
        } else {
            self.scrView.setZoomScale(1.0, animated: true)
        }
    }
    
    func zoomRectForScale(scale:CGFloat, center: CGPoint) -> CGRect{
        print("bbbbbbbbbbbbbbbbbb")
        let size = CGSize(
            width: self.scrView.frame.size.width / scale,
            height: self.scrView.frame.size.height / scale
        )
        return CGRect(
            origin: CGPoint(
                x: center.x - size.width / 2.0,
                y: center.y - size.height / 2.0
            ),
            size: size
        )
    }
    
    
}
