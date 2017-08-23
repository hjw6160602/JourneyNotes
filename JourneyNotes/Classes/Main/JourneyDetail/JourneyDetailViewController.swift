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
        view.addSubview(navigationBtn)
        view.addSubview(navigationView)
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
    
    lazy var navigationBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: SCREEN_WIDTH - 60, y: SCREEN_HEIGHT * 0.6, width: 50, height: 50))
        button.setImage(UIImage(named: "package_bg_routeList_50x50_"), for: .normal)
        _ = button.rx.tap.subscribe {[weak self] (event) in
            UIView.animate(withDuration: 0.3, animations: {
                self?.navigationView.x = 0
            })
        }
        return button
    }()
    
    /** 行程导航 */
    lazy var navigationView: UIView = {
        let view = UIView(frame: self.view.bounds)
        view.x = SCREEN_WIDTH
        
        view.backgroundColor = UIColor.clear
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        _ = tap.rx.event.subscribe { (event) in
            UIView.animate(withDuration: 0.3, animations: {
                view.x = SCREEN_WIDTH
            })
        }
        
        let frame = CGRect(x: 55, y: 0, width: SCREEN_WIDTH - 55, height: SCREEN_HEIGHT)
        var cover = UIView(frame: frame)
        cover.backgroundColor = rgbColor(0, 15, 34)
        cover.alpha = 0.9
        let naviTableView = JourneySummaryNavigationTableView(frame: frame, lineRouteDetailArr: self.journeyList)
        
        view.addSubview(cover)
        view.addSubview(naviTableView)
        return view
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



