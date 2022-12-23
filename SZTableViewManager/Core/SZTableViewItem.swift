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
        
    /*
     * cell相关的配置信息
     */
    // 自动高度
    public var estimated: Bool = false
    
    /*
     * cell的高度
     * 如果是自动高度模式，则为预估高度值
     */
    public var cellHeight: Float = 0.0
    
    // 如果提前计算好高度，可以将其设置为true避免重复计算
    public var didCalcHeight = false
    
    public override init() {
        super.init()
    }
    
    public convenience init(_ calc: Bool = false) {
        self.init()
        
        if calc {
            cellHeight = calcCellHeight()
        }
    }
    
    #if SZTableViewManagerDebug
    deinit {
        print("\(String(describing: Self.self)) \(#function)")
    }
    #endif
    
    // 当前item对应的section
    public weak var section: SZTableViewSection?
    
    // 推荐在Item数据初始化完成后，就计算cell的高度
    // 如果放到cell height里面再去计算，会有一定的性能消耗
    open func recalcCellHeight() {
        cellHeight = calcCellHeight()
        didCalcHeight = true
    }
    
    // 子类重写，返回与当前Item对应的Cell
    open class var cellClass: AnyClass {
        return SZTableViewCell.self
    }
    
    // 子类重写，返回当前Cell默认的高度
    open func calcCellHeight() -> Float {
        return 40.0
    }
}

extension SZTableViewItem {
    var cellClass: AnyClass {
        return Self.cellClass
    }
}

extension SZTableViewItem {
    public func reloadCurrentItem(_ animation: UITableView.RowAnimation = .automatic) {
        section?.reloadCurrentSectionItem(self, animation)
    }
}

//MARK: Item.Action
open class SZTableViewItemAction {
    open var selected: SZItemActionNormal?
}
