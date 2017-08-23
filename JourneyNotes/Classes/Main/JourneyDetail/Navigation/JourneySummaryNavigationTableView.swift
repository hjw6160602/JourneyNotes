//
//  JourneySummaryNavigationTableView.swift
//  JourneyNotes
//
//  Created by 贺嘉炜 on 2017/8/22.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

import UIKit

fileprivate let kCellReuseID: String = "JourneySummaryNavigationCell"

class JourneySummaryNavigationTableView: UITableView {
    var lineRouteDetailArr = [ProdLineRouteDetail]()
    var cellHeights: [Int: CGFloat] = [:]

    convenience init(frame: CGRect, lineRouteDetailArr: [ProdLineRouteDetail]) {
        self.init(frame: frame, style: .grouped)
        self.lineRouteDetailArr = lineRouteDetailArr
        dataSource = self
        delegate = self
        separatorStyle = .none
        backgroundColor = UIColor.clear
        bounces = false
        showsVerticalScrollIndicator = false
    }

}

extension JourneySummaryNavigationTableView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineRouteDetailArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kCellReuseID) as? JourneySummaryNavigationCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(kCellReuseID, owner: nil, options: nil)?.first as? JourneySummaryNavigationCell
        }
        cell?.setup(row: indexPath.row, eachDayEntity: self.lineRouteDetailArr[indexPath.row])
        cell?.isLastRow = (indexPath.row == (self.lineRouteDetailArr.count - 1));
        if self.cellHeights[indexPath.row] == nil {
            self.cellHeights[indexPath.row] = cell?.cellHeight;
        }
        return cell!
    }
}

extension JourneySummaryNavigationTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = cellHeights[indexPath.row] {
            return height
        } else {
            return 65
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("滚动到第几天呀？")
    }
}
