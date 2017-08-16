//
//  JourenyDetailShoppingEntity.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import Foundation

struct JourenyDetailShoppingEntity {
    var groupId: Int = 0
    /** 公里数 */
    var distanceKM: CGFloat = 0.0
    /** 出行类型（徒步、行驶）*/
    var travelType: String = ""
    /** 出行交通时间，几小时几分钟，另有全天，上午，下午等特殊值 */
    var travelTime: String = ""
    /** 是否使用话术模板 */
    var isUseTemplateFlag: Bool = false
    /** 话术模板编号 */
    var templateCode: String = ""
    /** 逻辑关系（和AND、或OR） */
    var logicRelation: String = ""
    /** 逻辑关系名称（和AND、或OR） */
    var logicRelationName: String = ""
    /** 创建时间 */
    var createTime: String = ""
    /** 修改时间 */
    var updateTime: String = ""
    // MARK: - 部分共有的属性
    /** 话术模板文本 */
    var templateText: String = ""
    /** 参观时间 */
    var visitTime: String = ""
    // MARK: - 特有的属性
    /** 主键ID */
    var shoppingId: Int = 0
    /** 购物点目的地的ID */
    var destId: Int = 0
    /** 购物点地址 */
    var address: String = ""
    /** 购物点名称 */
    var shoppingName: String = ""
    /** 主营产品 */
    var mainProducts: String = ""
    /** 兼营产品 */
    var subjoinProducts: String = ""
    /** 购物说明 */
    var shoppingDesc: String = ""
    /** 星级名称 */
    var starLevelName: String = ""
    /** 大于三星级显示 */
    var starBigThree: String = ""
}
