//
//  ViewController.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/15.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let numOfDays = 9
    let contents = ["住宿", "餐饮", "交通", "景点", "购物", "玩乐", "其他"]
    
    fileprivate let kReuseIdentifier = "reuseIdentifier"
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(-21, 0, 0, 0)
        
        writePlistFromJson()
        
        

    }
    
    
    private func readArrayFromPlist() -> NSArray {
        if let filePath = Bundle.main.path(forResource: "Journey", ofType: "plist") {
            let array = NSArray.init(contentsOfFile: filePath)!
            print(array)
            return array
        }
        return []
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
        return numOfDays
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kReuseIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: kReuseIdentifier)
        }
        cell!.textLabel?.text = contents[indexPath.row]
        return cell!
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let journeyDetailVC = JourneyDetailViewController.init(days: numOfDays)
//        journeyDetailVC.title = "第\(indexPath.section + 1)天  " + contents[indexPath.row]
        navigationController?.pushViewController(journeyDetailVC, animated: true)
    }
}


