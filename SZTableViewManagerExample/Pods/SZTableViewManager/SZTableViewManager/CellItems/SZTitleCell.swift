//
//  SZTitleCell.swift
//  iZeros
//
//  Created by Hui on 2022/12/9.
//

import Foundation
import UIKit
public class SZTitleCell: SZTableViewCell {
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 17.0)
        return lbl
    }()
    
    public override func didLoad(_ item: SZTableViewItem?) {
        super.didLoad(item)
        
        self.contentView.addSubview(self.titleLbl)
        self.titleLbl.frame = CGRect(x: 15, y: 10, width: 150, height: 24)
    }
    public override func didUpdate(_ item: SZTableViewItem?) {
        if let cellItem = item as? SZTitleCellItem {
            self.titleLbl.text = cellItem.title
        }
    }
}
