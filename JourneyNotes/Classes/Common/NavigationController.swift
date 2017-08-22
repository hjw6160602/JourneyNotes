//
//  NavigationController.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/15.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置显示的颜色
//        let image = UIImage.imageWithColor(color: rgbColor(245, 150, 170))
        let image = UIImage.imageWithColor(color: rgbColor(232, 122, 144))
//        let image2 = UIImage.init(named: "user_profile_header_background_320x100_");
        navigationBar.setBackgroundImage(image, for: .default)
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName:UIFont.boldSystemFont(ofSize: 18)]
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    /**
     *  重写这个方法目的：能够拦截所有push进来的控制器
     *  @param viewController 即将push进来的控制器
     */
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (childViewControllers.count > 0) {
            // 这时push进来的控制器viewController，不是第一个控制器（不是根控制器）
            navigationBar.isHidden = false
            
            let backBtn = UIButton()
            backBtn.size = CGSize(width: 25, height: 25)
            backBtn.setImage(UIImage(named: "dc_back_button_white_11x19_"), for: UIControlState())
            _ = backBtn.rx.tap.shareReplay(1).subscribe(onNext: {
                self.popToRootViewController(animated: true)
            })
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}
