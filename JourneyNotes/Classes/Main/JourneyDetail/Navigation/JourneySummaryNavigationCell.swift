//
//  JourneySummaryNavigationCell.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/22.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit

class JourneySummaryNavigationCell: UITableViewCell {

    /** 是否是最后一行 */
    var isLastRow: Bool = false
    /** cell的高度 */
    var cellHeight: CGFloat = 0.0
    
    @IBOutlet var cover: UIView!
    @IBOutlet var dayNumLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var lineView: UIView!
    
    @IBOutlet var titleLabelHeightCons: NSLayoutConstraint!
    @IBOutlet var contentLabelHeightCons: NSLayoutConstraint!
    
    var eachDayEntity: ProdLineRouteDetail?
    var row: Int = 0
    
    private let LineSpaceMargin: CGFloat = 11.0
    private var MinHeight: CGFloat = 65.0
    
    public func setup(row: Int, eachDayEntity: ProdLineRouteDetail) {
        self.row = row
        cellHeight = MinHeight
        titleLabelHeightCons?.constant = 20
        titleLabel?.text = ""
        contentLabel?.text = ""
        self.eachDayEntity = eachDayEntity
        setupData()
        //这里置为NO防止复用时，不显示了
        isLastRow = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        dayNumLabel.layer.cornerRadius = 15
        dayNumLabel.layer.borderColor = UIColor.white.cgColor
        dayNumLabel.layer.borderWidth = 1
        cover.isHidden = true
    }
    
    private func setupData() {
        dayNumLabel.text = "D\(row + 1)"
        lineView.isHidden = isLastRow
//        let maxWidth: CGFloat = SCREEN_WIDTH - 115
        titleLabel?.text = eachDayEntity?.title

        titleLabelHeightCons.constant = 20
        var content = String()
        let contentH: CGFloat = 20
        if let list = eachDayEntity?.prodRouteDetailGroupList {
            for clientItemEntity: JourenyDetailGroupEntity in list {
                //只提取景点信息
                if clientItemEntity.moduleType == "SCENIC" {
                    //当天有景点数据
                    if list.count > 0 {
                        // 行数 idx
                        var idx: Int = 1
                        
                        if let scenicList = clientItemEntity.prodRouteDetailScenicList {
                            for scenicEntity: JourenyDetailScenicEntity in scenicList{
                                let scenicName: String? = scenicEntity.scenicName
                                if let scenicName = scenicName {
                                    content += scenicName
                                }
                                
                                if idx < scenicList.count {
                                    content += "\n"
                                }
                                idx += 1
                            }
                        }
                        
                        // 静态显示textView的内容为设置的行间距
                        // 静态显示textView的内容为设置的行间距
                        let paragraphStyle = NSMutableParagraphStyle()
                        paragraphStyle.lineSpacing = LineSpaceMargin
                        // 字体的行间距
                        let textViewAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.paragraphStyle: paragraphStyle]
                        let attributeContent = NSMutableAttributedString(string: content, attributes: textViewAttributes)
                        contentLabel.attributedText = attributeContent
                    }
                }
            }
        }
        
        if content.count > 0 {
            contentLabelHeightCons.constant = contentH
            cellHeight = 20 + contentH + 40
        }
        else {
            contentLabelHeightCons.constant = 20
            cellHeight = MinHeight
        }
        height = cellHeight
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
