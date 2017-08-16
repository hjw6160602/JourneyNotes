//
//  ProdLineRoute.swift
//  JourneyNotes
//
//  Created by 贺嘉炜 on 2017/8/16.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

import Foundation

struct ProdLineRoute {
    var productId: Int64 = 0
    /** 几天 */
    var routeNum: Int = 0
    /** 几晚 */
    var stayNum: Int = 0
    /** 交通引起的天数(-1,0,1) */
    var trafficNum: Int = 0
    /** 线路id */
    var lineRouteId: Int64 = 0
    /** 行程明细列表 */
    var prodLineRouteDetailVoList = [ProdLineRouteDetail]()
    /** 行程结构化链接 */
    var lineDetailUrl: String = ""
    /** 行程结构化提示文案 */
    var lineDetailtext: String = ""
}
