//
//  ViewController.swift
//  JourneyNotes
//
//  Created by 贺嘉炜 on 2017/8/15.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let days = 9
    let contents = ["住宿", "餐饮", "交通", "景点", "购物", "玩乐", "其他"]
    
    fileprivate let kReuseIdentifier = "reuseIdentifier"
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(-21, 0, 0, 0)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return days
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kReuseIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: kReuseIdentifier)
        }
        cell!.textLabel?.text = contents[indexPath.row]
        return cell!
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = UIViewController()
        viewController.title = "第\(indexPath.section + 1)天  " + contents[indexPath.row]
        viewController.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(viewController, animated: true)
    }
}


