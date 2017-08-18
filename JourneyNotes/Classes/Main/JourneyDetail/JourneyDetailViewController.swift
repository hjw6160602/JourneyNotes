//
//  JourneyDetailViewController.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit

class JourneyDetailViewController: UIViewController {
    
    var journeyList: [ProdLineRouteDetail] = []
    var cellsArray: [JourneyDetaiTalbeViewCell] = []
    
    fileprivate let kReuseIdentifier = "journeyDetailReuseIdentifier"
    
    convenience init(journeyList list: [ProdLineRouteDetail]) {
        self.init()
        journeyList = list
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    private func setupUI() {
        title = "详细行程"
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func setupData() {
        for eachDayEntity in self.journeyList {
            let cell = JourneyDetaiTalbeViewCell(eachDayEntity: eachDayEntity, reuseIdentifier: kReuseIdentifier)
            cellsArray.append(cell)
        }
    }

    // MARK: - lazy loads
    lazy var tableView: UITableView = {
        let frame = CGRect.init(x: 0, y: 0, width: self.view.width, height: self.view.height - kNaviBarH)
        let tableView = UITableView(frame: frame, style: .grouped)
        tableView.backgroundColor = kGlobalGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
//        tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0)
        return tableView
    }()
}

extension JourneyDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = journeyList.count
        print(count)
        return journeyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellsArray[indexPath.row]
    }
}


extension JourneyDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = cellsArray[indexPath.row]
        return cell.height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}



