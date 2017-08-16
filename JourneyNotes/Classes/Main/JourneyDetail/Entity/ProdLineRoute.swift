//
//  ProdLineRoute.swift
//  JourneyNotes
//
//  Created by 贺嘉炜 on 2017/8/16.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

import Foundation

struct ProdLineRoute {
    /** 几天 */
    var routeNum: Int = 0
    /** 几晚 */
    var stayNum: Int = 0
    /** 线路id */
    var lineRouteId: Int64 = 0
    /** 行程明细列表 */
    var prodLineRouteDetailVoList = [ProdLineRouteDetail]()
}
