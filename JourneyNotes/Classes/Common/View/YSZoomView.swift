//
//  ImageZoomView.swift
//  图片浏览Swift
//
//  Created by SaiDicaprio on 16/5/6.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//  图片预览控件

import UIKit

class ImageZoomView: UIControl, UIScrollViewDelegate {
    
    private let maxScale: CGFloat = 3.0 // 最大的缩放比例
    private let minScale: CGFloat = 1.0 // 最小的缩放比例
    
    private let animDuration: TimeInterval = 0.2 // 动画时长
    
    // MARK: - Public property
    
    // 图片开始时的frame
    public var originFrame: CGRect = .zero
    // 要显示的图片
    public var image: UIImage? {
        didSet {
            if let _image = image {
                if self.originFrame == .zero {
                    let imageViewH = _image.size.height / _image.size.width * SCREEN_WIDTH
                    self.imageView?.bounds = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: imageViewH)
                    self.imageView?.center = (scrollView?.center)!
                } else {
                    self.imageView?.frame = self.originFrame
                }
                self.imageView?.image = image
            }
        }
    }

    // MARK: - Private property
    
    private var scrollView: UIScrollView?
    private var imageView: UIImageView?
    
    private var scale: CGFloat = 1.0 // 当前的缩放比例
    private var touchX: CGFloat = 0.0 // 双击点的X坐标
    private var touchY: CGFloat = 0.0 // 双击点的Y坐标
    
    private var isDoubleTapingForZoom: Bool = false // 是否是双击缩放
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 初始化View
        self.initAllView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        //当捏或移动时，需要对center重新定义以达到正确显示位置
        var centerX = scrollView.center.x
        var centerY = scrollView.center.y
        centerX = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width / 2 : centerX
        centerY = scrollView.contentSize.height > scrollView.frame.size.height ?scrollView.contentSize.height / 2 : centerY
        
        
        self.imageView?.center = CGPoint(x: centerX, y: centerY)
        
        // ****************双击放大图片关键代码*******************
        
        if isDoubleTapingForZoom {
            let contentOffset = self.scrollView?.contentOffset
            let center = self.center
            let offsetX = center.x - self.touchX
//            let offsetY = center.y - self.touchY
            self.scrollView?.contentOffset = CGPoint(x: (contentOffset?.x)! - offsetX * 2.2, y: (contentOffset?.y)!)
        }
        
        // ****************************************************
        
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.scale = scale
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView!
    }
    
    // MARK: - Event response
    // 单击手势事件
    @objc func singleTapClick(tap: UITapGestureRecognizer) {
        self.scrollView?.setZoomScale(self.minScale, animated: false)
        UIView.animate(withDuration: self.animDuration, delay: 0, options: .allowUserInteraction, animations: {
                self.imageView?.frame = self.originFrame
                self.scrollView?.backgroundColor = UIColor.clear
                // 把keyWindow的windowLevel设置为UIWindowLevelNormal
                UIApplication.shared.keyWindow?.windowLevel = UIWindow.Level.normal
            }) { (finished) in
                self.alpha = 0
                self.scrollView?.backgroundColor = UIColor.black
                self.originFrame = .zero
                self.scale = self.minScale
                self.removeFromSuperview()
                // 把keyWindow的windowLevel设置为UIWindowLevelNormal
//                UIApplication.sharedApplication().keyWindow?.windowLevel = UIWindowLevelNormal
        }
    }
    
    // 双击手势事件@objc
    @objc func doubleTapClick(tap: UITapGestureRecognizer) {
        self.touchX = tap.location(in: tap.view).x
        self.touchY = tap.location(in: tap.view).y
        
        if self.scale > 1.0 {
            self.scale = 1.0
            self.scrollView?.setZoomScale(self.scale, animated: true)
        } else {
            self.scale = maxScale
            self.isDoubleTapingForZoom = true
            self.scrollView?.setZoomScale(maxScale, animated: true)
        }
        self.isDoubleTapingForZoom = false
        
    }
    
    // MARK: - Private methods
    
    private func initAllView() {
        self.alpha = 0.0
        // UIScrollView
        self.scrollView = UIScrollView()
        self.scrollView?.showsVerticalScrollIndicator = false
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.scrollView?.maximumZoomScale = maxScale // scrollView最大缩放比例
        self.scrollView?.minimumZoomScale = minScale // scrollView最小缩放比例
        self.scrollView?.backgroundColor = UIColor.black
        self.scrollView?.delegate = self
        self.scrollView?.frame = self.bounds
        self.addSubview(self.scrollView!)
        
        // 添加手势
        // 1.单击手势
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ImageZoomView.singleTapClick(tap:)))
        
        singleTap.numberOfTapsRequired = 1
        self.scrollView?.addGestureRecognizer(singleTap)
        // 2.双击手势
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ImageZoomView.doubleTapClick(tap:)))
        
        doubleTap.numberOfTapsRequired = 2
        self.scrollView?.addGestureRecognizer(doubleTap)
        // 必须加上这句，否则双击手势不管用
        singleTap.require(toFail: doubleTap)
        
        // UIImageView
        self.imageView = UIImageView()
        self.scrollView?.addSubview(self.imageView!)
    }
    
    // MARK: - Public methods
    func show() {
        if let image = self.image {
            self.scrollView?.backgroundColor = UIColor.black
            UIView.animate(withDuration: self.animDuration, animations: { 
                self.imageView?.bounds = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: image.size.height / self.image!.size.width * SCREEN_WIDTH)
                self.imageView?.center = (self.scrollView?.center)!
                self.alpha = 1.0
            })
        } else {
            fatalError("传入图片为空！")
        }
    }
    
    // MARK: - deinit
    deinit {
        print("ZoomView.swift释放了！");
    }
}
