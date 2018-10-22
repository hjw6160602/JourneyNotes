//
//  AdditionProductBranch.swift
//  驴妈妈Swift
//
//  Created by SaiDicaprio on 2017/1/3.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit

class AdditionProductBranch: LvmmNetworkPort {
    
    
    
    open func request() {
        let host = "https://api3g2.lvmama.com"
        let page = "/api/router/rest.do?"
        let url = host + page
        
        

//        categoryCodeList	false	List<String>	品类 code
//        goodsId	false	Long[]	所选商品id
//        saleId	false	Long	团购/秒杀销售ID(产品:产品ID,商品:商品ID)
//        branchType	false	String	团购/秒杀类别(产品:PROD,商品:BRANCH)
        
        let params:[String:String] = ["version":"1.0.0",
                                      "productId":"861159",//产品ID
                                      "specDate":"2016-10-25",//出航日期
                                      "adultQty":"2",//成人数
                                      "childQty":"0",//儿童数
                                      "lvsessionid":"24157aa7-0f52-4723-996f-847c0314499a"
        ]
        
        //将参数尾巴拼接上去
//        params = TailTool().requestParams(paramDict: params, check: false, { (dict) in
//            dict["method"] = "api.com.ship.getShipGoodsAddition"
//        })
    
        
        print("最终的请求URL：\n\(url + params.flatmapOfDict)")
        
        postRequest(
        url: url, paramms: params) { (response, error) in
            guard error != nil else{
                if response is Dictionary<String, Any> {
                    let responseDict = response as!
                        Dictionary<String, Any>
                    print("服务器返回结果：\n\(responseDict)")
                    let code = responseDict["code"] as! String
                    if code == "1"{
                    }
                }
                return
            }
        }
    }
}
