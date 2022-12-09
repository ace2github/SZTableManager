//
//  SZTableViewCell.swift
//  iZeros
//
//  Created by Hui on 2022/12/8.
//

import Foundation
import UIKit

protocol SZTableViewCellLifeCircel {
    // 首次创建调用
    func didLoad(_ item: SZTableViewItem?)
    
    // 更新的时候调用，
    func didUpdate(_ item: SZTableViewItem?)
    
    //
    func willAppear(_ item: SZTableViewItem?)
    func didDisappear(_ item: SZTableViewItem?)
}

open class SZTableViewCell: UITableViewCell, SZTableViewCellLifeCircel {
    weak var innerItem: SZTableViewItem? = nil
    var loaded: Bool = false
    
    // 首次创建调用
    open func didLoad(_ item: SZTableViewItem?) {
        self.loaded = true
        
        // cell 样式配置
        self.selectionStyle = .none
    }
    
    open func didUpdate(_ item: SZTableViewItem?) {
        
    }
    open func willAppear(_ item: SZTableViewItem?) {
        
    }
    open func didDisappear(_ item: SZTableViewItem?) {
        
    }
}

