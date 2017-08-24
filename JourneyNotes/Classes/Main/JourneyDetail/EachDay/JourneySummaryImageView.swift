//
//  JourneySummaryImageView.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit
import Kingfisher

enum JourneySummayImageStyle : Int {
    case nothing = 0
    case one = 1
    case two = 2
    case three = 3
}

class JourneySummaryImageView: UIView {
    private let AspectRatio: CGFloat = 1.9
    
    /** 图片数组 */
    var imageUrls: [String]?
    /** 图片的数量 */
    var numOfPics: Int = 0
    /** 图片样式 */
    var style: JourneySummayImageStyle = .nothing
    /** 景点名称 */
    var name: String?
    
    convenience init(urls: [String]?, name: String?) {
        self.init()
        imageUrls = urls
        self.name = name
        if let count = urls?.count {
            numOfPics = count
        }
        if numOfPics <= 3 {
            style = JourneySummayImageStyle(rawValue: numOfPics)!
        }
        else {
            style = .three
        }
        setupUI()
    }
    
    private func setupUI () {
        var frameArr: [NSValue] = generateImageFrame()
        for index in 0..<frameArr.count {
            // 1.创建大的容器view
            let frame: CGRect = frameArr[index].cgRectValue
            let view = UIView(frame: frame)

            // 2.创建图片ImageView
            let imgView = UIImageView(frame: view.bounds)
            if let urls = imageUrls {
                let urlPath: String = urls[index]
                let url = URL(string: urlPath)
                imgView.kf.setImage(with: url)
            }
            
            // 添加手势
            let tapGesture = UITapGestureRecognizer()
            view.addGestureRecognizer(tapGesture)
            _ = tapGesture.rx.event.subscribe({ (event) in
                let zoomViewController = ImageZoomViewController()
                zoomViewController.image = imgView.image
                let navigationController = UIApplication.shared.delegate?.window??.rootViewController as! UINavigationController
                
                navigationController.pushViewController(zoomViewController, animated: true)
            })
            
            let cover = UIView(frame: CGRect(x: 0, y: view.height - 25, width: view.width, height: 25))
            cover.backgroundColor = grayColor(50)
            cover.alpha = 0.7
            
            // 3.创建景点名称label
            let nameLabelW: CGFloat = cover.width - MARGIN * 2
            let nameLabel = UILabel(frame: CGRect(x: MARGIN, y: view.height - 25, width: nameLabelW, height: 25))
            nameLabel.textColor = UIColor.white
            nameLabel.font = UIFont.systemFont(ofSize: 13)
            nameLabel.textAlignment = .center
            nameLabel.text = self.name
            
            // 4.将各种view添加
            view.addSubview(imgView)
            view.addSubview(cover)
            view.addSubview(nameLabel)
            addSubview(view)
        }
    }
    
    /** 生成所有图片的frame */
    private func generateImageFrame() -> [NSValue] {
        var frameArr: [NSValue] = []
        let bigImageW: CGFloat = SCREEN_WIDTH - 43
        let bigImageH: CGFloat = bigImageW / AspectRatio
        let smallImageW: CGFloat = (bigImageW - MARGIN) / 2
        let smallImageH: CGFloat = smallImageW / AspectRatio
        var currentHeight: CGFloat = 0
        switch style {
        case .one:
            let frame = CGRect(x: 0, y: 0, width: bigImageW, height: bigImageH)
            let value = NSValue(cgRect: frame)
            frameArr.append(value)
            currentHeight = bigImageH + MARGIN
        case .two:
            var frame = CGRect(x: 0, y: 0, width: smallImageW, height: smallImageH)
            let value1 = NSValue(cgRect: frame)
            frame.origin.x = smallImageW + MARGIN
            let value2 = NSValue(cgRect: frame)
            frameArr.append(value1)
            frameArr.append(value2)
            currentHeight = smallImageH

        case .three:
            let frame1 = CGRect(x: 0, y: 0, width: bigImageW, height: bigImageH)
            let value1 = NSValue(cgRect: frame1)
            var frame2 = CGRect(x: 0, y: bigImageH + MARGIN, width: smallImageW, height: smallImageH)
            let value2 = NSValue(cgRect: frame2)
            frame2.origin.x = smallImageW + MARGIN
            let value3 = NSValue(cgRect: frame2)
            frameArr.append(value1)
            frameArr.append(value2)
            frameArr.append(value3)
            currentHeight = bigImageH + smallImageH + MARGIN * 2
        default:
            break
        }
        //根据图片的frame反推出当前view的frame
        frame = CGRect(x: 0, y: 0, width: bigImageW, height: currentHeight)
        return frameArr
    }
    
}
