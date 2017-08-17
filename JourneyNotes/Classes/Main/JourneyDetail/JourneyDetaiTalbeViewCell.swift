//
//  JourneyDetaiTalbeViewCell.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit

fileprivate let marginH: CGFloat = 5.0
fileprivate let LineSpaceMargin: CGFloat = 4

class JourneyDetaiTalbeViewCell: UITableViewCell {

    var eachDayEntity: ProdLineRouteDetail = ProdLineRouteDetail()
    var titleLabelTxt = ""
    var briefLabelTxt = ""
    var contentLabelTxt = ""
    
    /** 用来保存Cell的高度 */
    var cellHeight: CGFloat = 0.0
    
    convenience init(eachDayEntity: ProdLineRouteDetail, reuseIdentifier: String) {
        self.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.eachDayEntity = eachDayEntity
        initUI()
    }

    private func initUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(nDayLabel)
        for itemEntity: JourenyDetailGroupEntity in self.eachDayEntity.prodRouteDetailGroupList {
            print(itemEntity.detailId)
            addEachDayItemView(withStyle: getItemStyle(itemEntity.moduleType), itemEntity: itemEntity)
        }
        let seperatorLineH: CGFloat = 0.5
        cellHeight += marginH
        let seperatorLineY: CGFloat = cellHeight - seperatorLineH

        let frame = CGRect.init(x: 10, y: seperatorLineY, width: SCREEN_WIDTH, height: seperatorLineH)
        let seperatorLine = UIView(frame:frame)
        seperatorLine.backgroundColor = UIColor.lightGray
        contentView.addSubview(seperatorLine)
        height = cellHeight
    }
    
    /** 根据 moduleType 字段来区分行程项目的类型 */
    
    private func getItemStyle(_ moduleType: String) -> JourneySummaryItemStyle {
        var style: JourneySummaryItemStyle = .scenic
        if (moduleType == "SCENIC") {
            style = .scenic
        }
        else if (moduleType == "HOTEL") {
            style = .hotel
        }
        else if (moduleType == "VEHICLE") {
            style = .vehicle
        }
        else if (moduleType == "MEAL") {
            style = .meal
        }
        else if (moduleType == "SHOPPING") {
            style = .shopping
        }
        return style
    }
    
    private func addEachDayItemView(withStyle style: JourneySummaryItemStyle, itemEntity: JourenyDetailGroupEntity) {
        let frame = CGRect(x: 0, y: cellHeight, width: SCREEN_WIDTH, height: 50)
        let itemView = JourneyEachDayItemView.init(style: style, itemEntity: itemEntity, frame: frame)
        itemView.backgroundColor = UIColor.cyan
        cellHeight += itemView.height
        contentView.addSubview(itemView)
    }

    // MARK: - lazy loads
    /** 标题Label */
    lazy var nDayLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: 50, height: 30))
        label.numberOfLines = 0
        
        label.text = self.titleLabelTxt
        label.textColor = UIColor.red
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "第\(self.eachDayEntity.nDay)天"
        return label
    }()
    
    /** 标题Label */
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = self.titleLabelTxt
        label.textColor = UIColor.darkGray
        return label
    }()
    
    /** 标题Label */
    lazy var briefLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = self.titleLabelTxt
        label.textColor = UIColor.darkGray
        return label
    }()
    
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = self.titleLabelTxt
        label.textColor = UIColor.darkGray
        // 静态显示textView的内容为设置的行间距
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = LineSpaceMargin
        // 字体的行间距
        var textViewAttributes: [AnyHashable: Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSParagraphStyleAttributeName: paragraphStyle]
        var attributeContent = NSMutableAttributedString(string: self.contentLabelTxt, attributes: textViewAttributes as? [String : Any] ?? [String : Any]())
        label.attributedText = attributeContent
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
