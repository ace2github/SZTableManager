//
//  SZTableViewSection.swift
//  iZeros
//
//  Created by Hui on 2022/12/8.
//

import Foundation
import UIKit

open class SZTableViewSection: NSObject {
    var cellItems: [SZTableViewItem] = [SZTableViewItem]()
    
    public weak var tablemanager: SZTableViewManager?
    
    //MARK: Header
    public var headerHeight: Float = 0.0
    public var headerView: UIView? = nil
    
    //MARK: Footer
    public var footerHeight: Float = 0.0
    public var footerView: UIView? = nil

    public override init() {
        super.init()
        headerHeight = Self.calcHeaderHeight()
        footerHeight = Self.calcFooterHeight()
    }
    
    deinit {
        #if SZTableViewManagerDebug
        print("\(String(describing: Self.self)) \(#function)")
        #endif
        
        cellItems.removeAll()
        
        footerView?.removeFromSuperview()
        footerView = nil
        
        headerView?.removeFromSuperview()
        headerView = nil
    }
    
    open class func calcHeaderHeight() -> Float {
        return 0.0
    }
    open class func calcFooterHeight() -> Float {
        return 0.0
    }
}


extension SZTableViewSection {
    func safeItem(_ index: Int) -> SZTableViewItem? {
        guard index < self.cellItems.count else {
            return nil
        }
        
        return self.cellItems[index]
    }
    
    public func addItem(_ item: SZTableViewItem) {
        item.section = self
        self.cellItems.append(item);
    }
    
    public func addItemList(_ itemList: [SZTableViewItem]) {
        for item in itemList {
            addItem(item)
        }
    }
    
    public func insertItem(_ item: SZTableViewItem, _ atIndex:Int) -> Bool{
        if atIndex < self.cellItems.count {
            item.section = self
            self.cellItems.insert(item, at: atIndex)
            return true
        }
        return false
    }
    
    public func deleteItem(_ item: SZTableViewItem){
        if let index = self.cellItems.firstIndex(of: item) {
            self.cellItems.remove(at: index)
        }
    }
    
    public func itemIndex(_ item: SZTableViewItem) -> Int {
        return self.cellItems.firstIndex(of: item) ?? -1
    }
}


extension SZTableViewSection {
    public func reloadCurrentSection() {
        tablemanager?.relaodTableView(self)
    }
    
    public func reloadCurrentSectionItem(_ item: SZTableViewItem) {
        tablemanager?.relaodTableView(self, [item])
    }
}
