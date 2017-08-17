//
//  JourneyDetailViewController.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit

class JourneyDetailViewController: UIViewController {
    
    var journeyList:[ProdLineRouteDetail] = []
    
    let tableView = UITableView.init(frame: SCREEN_FRAME, style: .grouped)
    
    fileprivate let kReuseIdentifier = "journeyDetailReuseIdentifier"
    
    convenience init(journeyList list: [ProdLineRouteDetail]) {
        self.init()
        journeyList = list
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
        return journeyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kReuseIdentifier)
        if cell == nil {
//            cell = JourneyDetaiTalbeViewCell.init(style: .default, reuseIdentifier: kReuseIdentifier)
            cell = JourneyDetaiTalbeViewCell.init(eachDayEntity: self.journeyList[indexPath.row], reuseIdentifier: kReuseIdentifier)
        }
        cell!.textLabel?.text = "\(indexPath.row + 1)"
        return cell!
    }
}


extension JourneyDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
}









