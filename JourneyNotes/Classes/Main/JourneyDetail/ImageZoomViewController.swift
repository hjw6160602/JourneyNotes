//
//  ImageZoomViewController.swift
//  JourneyNotes
//
//  Created by 贺嘉炜 on 2017/8/23.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

import UIKit

class ImageZoomViewController: UIViewController, UIScrollViewDelegate {

    var image: UIImage?
    let scrollview = UIScrollView()
    var imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollview.frame = view.bounds
        view.addSubview(scrollview)
        
        if let image = self.image {
            imageView.image = image
            imageView.centerY = view.centerY
            imageView.size = image.size
            
            //调用initWithImage:方法，它创建出来的imageview的宽高和图片的宽高一样
            scrollview.addSubview(imageView)
            //设置UIScrollView的滚动范围和图片的真实尺寸一致
            scrollview.contentSize = image.size
            //设置实现缩放
            //设置代理scrollview的代理对象
            scrollview.delegate = self
            //设置最大伸缩比例
            scrollview.maximumZoomScale = 2.0
            //设置最小伸缩比例
            scrollview.minimumZoomScale = 0.5
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
//    lazy var imageView: UIImageView = {
//        let imageView = UIImageView(frame: self.view.bounds)
//        imageView.isUserInteractionEnabled = true
//        imageView.contentMode = .scaleAspectFit
//        let tapGesture = UITapGestureRecognizer()
//        imageView.addGestureRecognizer(tapGesture)
//        imageView.image = self.image
//        _ = tapGesture.rx.event.subscribe {[weak self] (event) in
//            self?.zoomView.image = self?.imageView.image
//            self?.zoomView.show()
//        }
//        return imageView
//    }()
}
