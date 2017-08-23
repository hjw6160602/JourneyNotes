//
//  ViewController.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/15.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /** 原始数据 */
    var jsonList: NSArray = []
    /** 解析过后的数据 */
    var journeyList: [ProdLineRouteDetail] = []
    
    fileprivate let kReuseIdentifier = "reuseIdentifier"
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        writePlistFromJson()
        jsonList = readArrayFromPlist()
        parseEntityFromJson()
    }
    
    private func readArrayFromPlist() -> NSArray {
        if let filePath = Bundle.main.path(forResource: "Journey", ofType: "plist") {
            let array = NSArray.init(contentsOfFile: filePath)!
            return array
        }
        return []
    }
    
    private func parseEntityFromJson() {
        for item in jsonList {
            let jsonDict = item as! [String:AnyObject]
            if let eachDayEntity = try? ProdLineRouteDetail.decodeValue(jsonDict) {
                journeyList.append(eachDayEntity)
            }
        }
    }
    
    private func writePlistFromJson() {
        if let filePathUrl = Bundle.main.url(forResource: "Journey", withExtension: "plist") {
            do {
                let json = try String.init(contentsOf: filePathUrl)
                if let responseDict = json.stringToDic {
                    let nsDict:NSDictionary = responseDict as NSDictionary
                    let filePath = DOC_PATH! + "/Journey.plist"
                    nsDict.write(toFile: filePath, atomically: true)
                    
                    let journeyDetails = responseDict["prodLineRouteDetailVoList"]!
                    print(journeyDetails)
                }
            } catch {
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return jsonList.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section > 0 {
            return 5
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kReuseIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: kReuseIdentifier)
        }
        if indexPath.section == 0 {
            cell?.textLabel?.text = "查看全部行程"
        } else {
            let (titleName, iconName) = generateTitleAndIcon(indexPath: indexPath)
            cell?.imageView?.image = UIImage(named: iconName)
            cell?.textLabel?.text = titleName
        }
        dealCellStyle(cell: cell!, indexPath: indexPath)
        return cell!
    }
    
    /** 生成cell的icon和标题 */
    private func generateTitleAndIcon(indexPath: IndexPath) -> (titleName: String, iconName: String) {
        var titleName = ""
        var iconName: String = ""
        switch indexPath.row {
        case 0:
            titleName = "第 \(indexPath.section) 天"
        case 1:
            iconName = "journey_icon_scenic_18x18_"
            titleName = "景点"
        case 2:
            iconName = "icon_playDetail_bus_18x18_"
            titleName = "交通"
        case 3:
            iconName = "boss3_diy_hotel_18x18_"
            titleName = "住宿"
        case 4:
            titleName = "查看当天全部行程"
        default: break
        }
        return (titleName, iconName)
    }
    
    private func dealCellStyle(cell:UITableViewCell, indexPath:IndexPath) {
        cell.textLabel?.textColor = kTextBlack
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .default
        if indexPath.section > 0 {
            if indexPath.row == 0 {
                cell.textLabel?.textColor = kGlobalPink
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                cell.accessoryType = .none
                cell.selectionStyle = .none
            } else if indexPath.row < 4 {
                cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard indexPath.section > 0 && indexPath.row == 0 else {
            let journeyDetailVC = JourneyDetailViewController.init(journeyList: journeyList)
            //        journeyDetailVC.title = "第\(indexPath.section + 1)天  " + contents[indexPath.row]
            navigationController?.pushViewController(journeyDetailVC, animated: true)
            return
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
}


