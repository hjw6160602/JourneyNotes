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
        view.addSubview(backTopBtn)

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
        return tableView
    }()
    
    lazy var backTopBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: SCREEN_WIDTH - 60, y: SCREEN_HEIGHT * 0.7, width: 50, height: 50))
        button.setImage(UIImage(named: "super_icon_toTop_50x50_"), for: .normal)
        _ = button.rx.tap.subscribe {[weak self] (event) in
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        return button
    }()
}

extension JourneyDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = journeyList.count
        print(count)
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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



