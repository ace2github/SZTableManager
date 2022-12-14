//
//  MainViewController.swift
//  SZTableViewManagerExample
//
//  Created by Hui on 2022/12/12.
//

import Foundation
import SZTableViewManager

class MainViewController: UIViewController {
    lazy var tableview: UITableView = {
        let tblV = UITableView(frame:self.view.bounds, style:.plain)
        return tblV
    }()
    
    let tblManager: SZTableViewManager = SZTableViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .orange
        self.view.addSubview(self.tableview)
        tblManager.bindTableView(self.tableview)
        
        self.tableview.separatorStyle = .singleLine
        
        tblManager.registerList([
            SZTitleCellItem.self,
            ImageTitleCellItem.self,
            BigImageCellItem.self
        ])
        
        let section: SZTableViewSection = SZTableViewSection.init()
        for i in 0...8 {
            let item = SZTitleCellItem()
            item.title = "title \(i)"
            item.action.selected = { [weak self] (_ vi: SZTableViewItem? ,_ tblMgr: SZTableViewManager) in
                if let cellItem = vi as? SZTitleCellItem {
                    print("click: \(cellItem.title)")
                    self?.navigationController?.pushViewController(ViewController.init(), animated: true)
                }
            }
            section.addItem(item)
            
            if i == 3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                    item.title = item.title + " + update"
                    item.reloadCurrentItem()
                })
            }
        }
        tblManager.addSection(section)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
//            section.reloadCurrentSection()
//        })
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
//            self.tblManager.clearDatasource()
//        })
    }
}
