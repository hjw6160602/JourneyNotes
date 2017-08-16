//
//  JourneyDetailViewController.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit

class JourneyDetailViewController: UIViewController {

    var numOfDays:Int = 0
    let tableView = UITableView.init(frame: SCREEN_FRAME, style: .grouped)
    
    fileprivate let kReuseIdentifier = "journeyDetailReuseIdentifier"
    
    convenience init(days numOfDays:Int) {
        self.init()
        self.numOfDays = numOfDays
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "详细行程"
        view.backgroundColor = UIColor.white
        setupTableView()
        view.addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension JourneyDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfDays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kReuseIdentifier)
        if cell == nil {
            cell = JourneyDetaiCell.init(style: .default, reuseIdentifier: kReuseIdentifier)
        }
        cell!.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    
}


extension JourneyDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
}









