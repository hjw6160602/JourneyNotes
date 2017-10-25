//
//  JourneyDetaiTalbeViewCell.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//  每一个Cell代表一天

import UIKit
import SnapKit

fileprivate let marginH: CGFloat = 5.0

class JourneyDetaiTalbeViewCell: UITableViewCell {

    var eachDayEntity: ProdLineRouteDetail = ProdLineRouteDetail()
    
    /** 用来保存Cell的高度 */
    var cellHeight: CGFloat = 0.0
    
    convenience init(eachDayEntity: ProdLineRouteDetail, reuseIdentifier: String) {
        self.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.eachDayEntity = eachDayEntity
        selectionStyle = .none
        initUI()
    }

    private func initUI() {
        contentView.addSubview(nDayLabel)
        contentView.addSubview(seperateView)
        contentView.addSubview(titleNameLabel)
        contentView.addSubview(seperatorLine)
        
        cellHeight = 100
        for itemEntity: JourenyDetailGroupEntity in self.eachDayEntity.prodRouteDetailGroupList {
            if let moduleTpye = itemEntity.moduleType {
                let itemStyle = getItemStyle(moduleTpye)
                // 如果能够拿到项目类型
                if itemStyle != .nothing {
                    // 那么将其添加上来
                    addEachDayItemView(withStyle: itemStyle, itemEntity: itemEntity)
                }
            }
        }
        // 给出 cell 的高度
        height = cellHeight + MARGIN * 2
        cellHeight = height
        print(height)
        
    }
    
    /** 根据 moduleType 字段来区分行程项目的类型 */
    private func getItemStyle(_ moduleType: String) -> JourneySummaryItemStyle {
        var style: JourneySummaryItemStyle = .nothing
        if (moduleType == "SCENIC") {
            style = .scenic
        }
        else if (moduleType == "HOTEL") {
            style = .hotel
        }
        else if (moduleType == "VEHICLE") {
            style = .vehicle
        }
        // 暂不设置餐饮和购物字段
//        else if (moduleType == "MEAL") {
//            style = .meal
//        }
//        else if (moduleType == "SHOPPING") {
//            style = .shopping
//        }
        return style
    }
    
    private func addEachDayItemView(withStyle style: JourneySummaryItemStyle, itemEntity: JourenyDetailGroupEntity) {
        let frame = CGRect(x: 0, y: cellHeight, width: SCREEN_WIDTH, height: 50)
        let itemView = JourneyEachDayItemView.init(style: style, entity: itemEntity, frame: frame)
        cellHeight += itemView.height
        contentView.addSubview(itemView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        seperateView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(MARGIN)
        }
        nDayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(7)
            make.size.equalTo(CGSize.init(width: 80, height: 30))
            make.centerX.equalToSuperview()
        }
        titleNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nDayLabel.snp.bottom)
            make.left.equalTo(MARGIN)
            make.right.equalTo(-MARGIN)
            make.height.equalTo(60)
        }
        seperatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleNameLabel.snp.bottom)
            make.left.equalTo(MARGIN)
            make.right.equalTo(-MARGIN)
            make.height.equalTo(1)
        }
    }

    lazy var seperateView: UIView = {
        let view = UIView()
        view.backgroundColor = kGlobalGray
        return view
    }()
    
    // MARK: - lazy loads
    /** 第几天 Label */
    lazy var nDayLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = kGlobalPink
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.white
        label.text = "第\(self.eachDayEntity.nDay)天"
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        return label
    }()
    
    /** 标题 Label */
    lazy var titleNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.text = self.eachDayEntity.title
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var seperatorLine: UIView = {
        let seperatorLine = UIView()
        seperatorLine.backgroundColor = kGlobalGray
        return seperatorLine
    }()
}

extension JourneyDetaiTalbeViewCell {
    
}
