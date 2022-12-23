//
//  SZTableViewManager.swift
//  iZeros
//
//  Created by Hui on 2022/12/8.
//

import Foundation
import UIKit

public class SZTableViewManager : NSObject {    // sections
    fileprivate var sectionList: [SZTableViewSection] = [SZTableViewSection]()
    
    // tableview 由外部自行管理
    fileprivate weak var tableview: UITableView?
    
    deinit {
        #if SZTableViewManagerDebug
        print("\(String(describing: Self.self)) \(#function)")
        #endif
        
        // 清理tableview
        tableview?.delegate = nil
        tableview?.dataSource = nil
        tableview = nil
        
        sectionList.removeAll()
    }
    
    public func bindAndRegister(_ tblV: UITableView, _ itemClsList: [SZTableViewItem.Type]) {
        bindTableView(tblV)
        registerList(itemClsList)
    }
    
    // 1、必须先绑定TableView
    public func bindTableView(_ tblV: UITableView) {
        tblV.delegate = self
        tblV.dataSource = self
        
        // 配置TableView
        tblV.separatorStyle = .none
        tblV.layoutMargins = UIEdgeInsets.zero
        tblV.estimatedRowHeight = 0
        tblV.estimatedSectionFooterHeight = 0
        tblV.estimatedSectionHeaderHeight = 0
        
        tableview = tblV
    }
    
    // 2、强制采用注册Class的方式
    public func registerList(_ itemClsList: [SZTableViewItem.Type]) {
        for itemCls in itemClsList {
            registerItem(itemCls)
        }
    }
    public func registerItem(_ itemCls: SZTableViewItem.Type) {
        guard let tbl = tableview else {
            assert(self.tableview==nil, "tableview not bind！")
            return
        }
        
        let reuseIdentifier = cellReuseIdentifier(itemCls.cellClass)
        tbl.register(itemCls.cellClass, forCellReuseIdentifier: reuseIdentifier)
    }
}

extension SZTableViewManager {
    public func reloadTableView() {
        //assert(Thread.isMainThread, "非主线程刷新")
        tableview?.reloadData()
    }
    public func reloadSectionIndexTitles() {
        //assert(Thread.isMainThread, "非主线程刷新")
        tableview?.reloadSectionIndexTitles()
    }
    public func reloadInputViews() {
        //assert(Thread.isMainThread, "非主线程刷新")
        tableview?.reloadInputViews()
    }
    
    public func relaodTableView(_ section: SZTableViewSection,
                                _ animation: UITableView.RowAnimation = .automatic)
    {
        //assert(Thread.isMainThread, "非主线程刷新")
        let si = sectionIndex(section)
        if si >= 0 {
            tableview?.reloadSections(IndexSet(integer: si), with: animation)
        }
    }
    
    public func relaodTableView(_ section: SZTableViewSection,
                                _ itemlist: [SZTableViewItem],
                                _ animation: UITableView.RowAnimation = .automatic)
    {
        //assert(Thread.isMainThread, "非主线程刷新")
        let si = sectionIndex(section)
        
        if si >= 0{
            var indexpathList = [IndexPath]()
            
            for item in itemlist {
                let ri = section.itemIndex(item)
                
                // 一个异常直接退出
                if ri < 0 {
                    print("item index out of bounds")
                    return
                }
                
                indexpathList.append(IndexPath.init(row: ri, section: si))
            }
                
            if indexpathList.count > 0 {
                tableview?.reloadRows(at: indexpathList, with: UITableView.RowAnimation.automatic)
            }
        }
    }
    
    public func clearDatasource(_ reload: Bool = true) {
        //assert(Thread.isMainThread, "非主线程刷新")

        self.sectionList.removeAll()
        if reload {
            tableview?.reloadData()
        }
    }
}
    
extension SZTableViewManager {
    public func addSection(_ section: SZTableViewSection) {
        section.tablemanager = self
        self.sectionList.append(section);
    }
    public func addSectionList(_ list: [SZTableViewSection]) {
        for s in list {
            addSection(s)
        }
    }
    public func replaceSectionList(_ list: [SZTableViewSection]) {
        removeAll()
        for s in list {
            addSection(s)
        }
    }

    public func deleteSection(_ section: SZTableViewSection){
        if let index = self.sectionList.firstIndex(of: section) {
            self.sectionList.remove(at: index)
        }
    }
    
    public func safeSection(_ index: Int) -> SZTableViewSection? {
        guard index < self.sectionList.count else {
            return nil
        }
        
        return self.sectionList[index]
    }
    
    public func sectionIndex(_ section: SZTableViewSection) -> Int {
        return self.sectionList.firstIndex(of: section) ?? -1
    }
    
    public func sectionCount() -> Int {
        return self.sectionList.count
    }
    
    public func removeAll() {
        return self.sectionList.removeAll()
    }
}


/*
 需要进行给外部代理的机会
 */
extension SZTableViewManager : UITableViewDelegate {
    //MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellItem = safeSection(indexPath.section)?.safeItem(indexPath.row)
        if let handler = cellItem?.action.selected {
            handler(cellItem, self)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellItem = safeSection(indexPath.section)?.safeItem(indexPath.row) else {
            return 0.0
        }
        
        if cellItem.estimated {
            return UITableView.automaticDimension
        }
        
        // 计算cell的高度，只计算一次，内部缓存
        if cellItem.didCalcHeight == false {
            cellItem.recalcCellHeight()
        }
        
        return CGFloat(cellItem.cellHeight)
    }
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellItem = safeSection(indexPath.section)?.safeItem(indexPath.row) else {
            return 0.0
        }
        
        // 计算cell的高度，只计算一次，内部缓存
        if cellItem.didCalcHeight == false {
            cellItem.recalcCellHeight()
        }
        return CGFloat(cellItem.cellHeight)
    }

    //MARK: display
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellItem = safeSection(indexPath.section)?.safeItem(indexPath.row)
        if let tmp_cell = cell as? SZTableViewCell {
            tmp_cell.willAppear(cellItem)
        }
    }
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellItem = safeSection(indexPath.section)?.safeItem(indexPath.row)
        if let tmp_cell = cell as? SZTableViewCell {
            tmp_cell.didDisappear(cellItem)
        }
    }

    /*
     header and fooder
     */
    //MARK: header and fooder
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionItem = safeSection(section) else {
            return 0.0
        }
        
        if sectionItem.estimatedHeader {
            return UITableView.automaticDimension
        }
        
        return CGFloat(sectionItem.headerHeight)
    }
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionItem = safeSection(section) else {
            return 0.0
        }
        
        return CGFloat(sectionItem.footerHeight)
    }
    

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let sectionItem = safeSection(section) else {
            return 0.0
        }
        
        if sectionItem.estimatedFooter {
            return UITableView.automaticDimension
        }
        
        return CGFloat(sectionItem.footerHeight)
    }
    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        guard let sectionItem = safeSection(section) else {
            return 0.0
        }
        
        return CGFloat(sectionItem.footerHeight)
    }

    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let sectionItem = safeSection(section) {
            return sectionItem.headerView
        }
        return nil
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let sectionItem = safeSection(section) {
            return sectionItem.footerView
        }
        return nil
    }
}


/*
 需要进行给外部代理的机会
 */
extension SZTableViewManager : UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionList.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return safeSection(section)?.cellItems.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: SZTableViewCell? = nil
        
        // 获取item
        let item = safeSection(indexPath.section)?.safeItem(indexPath.row)
        
        // 创建 item 对应的 cell
        if let tmp_item = item {
            // 判断是否为SZTableViewCell类型
            if tmp_item.cellClass is SZTableViewCell.Type {
                let reuseIdentifier = cellReuseIdentifier(tmp_item.cellClass)
                cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SZTableViewCell
            }
        }
        
        // 如果为空，则创建默认的
        if cell == nil {
            cell = createDefaultCell()
        }
        
        // 初始化
        if cell?.loaded == false {
            cell?.loaded = true
            cell?.didLoad(item)
        }
        
        // 配置
        cell?.innerItem = item
        
        // 更新数据
        cell?.didUpdate(item)
        
        return cell!
    }
    
    func createDefaultCell() -> SZTableViewCell {
        let reuseIdentifier = cellReuseIdentifier(SZTableViewCell.self)
        return SZTableViewCell.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    func cellReuseIdentifier(_ itemCls: AnyClass) -> String {
        return "SZ_\(String(describing: itemCls))"
    }
}
