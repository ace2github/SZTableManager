//
//  SZTitleCellItem.swift
//  iZeros
//
//  Created by Hui on 2022/12/9.
//

import Foundation

public class SZTitleCellItem: SZTableViewItem {
    public var title: String = ""
    public var desc: String = ""
    
    public override class var cellClass: AnyClass {
        return SZTitleCell.self
    }
    public override func calcCellHeight() -> Float {
        return 44.0
    }
}
