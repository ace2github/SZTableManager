//
//  SZTableViewItem.swift
//  iZeros
//
//  Created by Hui on 2022/12/8.
//

import Foundation
import UIKit


open class SZTableViewItem : NSObject {
    // action
    open lazy var action: SZTableViewItemAction = {
        return SZTableViewItemAction()
    }()
        
    // cell相关的配置信息
    public var cellHeight: Float = 0.0
    public override init() {
        super.init()
        cellHeight = Self.calcCellHeight()
    }
    
    #if SZTableViewManagerDebug
    deinit {
        print("\(String(describing: Self.self)) \(#function)")
    }
    #endif
    
    // 当前item对应的section
    public weak var section: SZTableViewSection?
    
    // 子类重写，返回与当前Item对应的Cell
    open class var cellClass: AnyClass {
        return SZTableViewCell.self
    }
    
    // 子类重写，返回当前Cell默认的高度
    open class func calcCellHeight() -> Float {
        return 40.0
    }
}

extension SZTableViewItem {
    var cellClass: AnyClass {
        return Self.cellClass
    }
}

extension SZTableViewItem {
    public func reloadCurrentItem() {
        section?.reloadCurrentSectionItem(self)
    }
}

//MARK: Item.Action
open class SZTableViewItemAction {
    open var selected: SZItemActionNormal?
}
