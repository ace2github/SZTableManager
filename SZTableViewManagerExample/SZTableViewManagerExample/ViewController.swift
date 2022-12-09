//
//  ViewController.swift
//  SZTableViewManagerExample
//
//  Created by Hui on 2022/12/9.
//

import UIKit
import SZTableViewManager

class ViewController: UIViewController {
    lazy var tableview: UITableView = {
        let tblV = UITableView(frame:self.view.bounds, style:.plain)
        return tblV
    }()
    
    let tblManager: SZTableViewManager = SZTableViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(self.tableview)
        tblManager.bindTableView(self.tableview)
        
        self.tableview.separatorStyle = .singleLine
        
        tblManager.registerList([
            SZTitleCellItem.self,
            ImageTitleCellItem.self
        ])
        
        let section: SZTableViewSection = SZTableViewSection.init()
        let hv = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 60))
        hv.backgroundColor = .white
        section.headerView = hv
        section.headerHeight = 60

//        let fv = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 60))
//        fv.backgroundColor = .red
//        section.footerView = fv
//        section.footerHeight = 60
        
        for i in 0...100 {
            let type = i % 2
            switch type {
            case 0:
                let item = SZTitleCellItem()
                item.title = "TitleCell \(i)"
                item.action.selected = { (_ vi: SZTableViewItem? ,_ tblMgr: SZTableViewManager) in
                    if let cellItem = vi as? SZTitleCellItem {
                        print("click: \(cellItem.title)")
                    }
                }
                section.addItem(item)
            case 1:
                let item = ImageTitleCellItem()
                item.title = "ImageTitle \(i)"
                item.action.selected = { (_ vi: SZTableViewItem? ,_ tblMgr: SZTableViewManager) in
                    if let cellItem = vi as? ImageTitleCellItem {
                        print("click: \(cellItem.title)")
                    }
                }
                section.addItem(item)
            default:
                print("undefine")
            }
        }
        tblManager.addSection(section)
    }
}

