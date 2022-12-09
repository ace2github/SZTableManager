//
//  ImageTitleCell.swift
//  SZTableViewManagerExample
//
//  Created by Hui on 2022/12/9.
//

import Foundation
import SZTableViewManager

class ImageTitleCell: SZTableViewCell {
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .blue
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    lazy var iconImgV: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage.init(named: "facebook")
        return imgV
    }()
    
    override func didLoad(_ item: SZTableViewItem?) {
        super.didLoad(item)
        if let cellItem = item as? ImageTitleCellItem {
            print("\(#function) \(cellItem.title)")
            self.iconImgV.frame = CGRect(x: 5, y: 5, width: 50, height: 50)
            self.contentView.addSubview(self.iconImgV)

            self.titleLbl.frame = CGRect(x: 60, y: 5, width: 150, height: 20)
            self.contentView.addSubview(self.titleLbl)
        }
    }

    override func didUpdate(_ item: SZTableViewItem?) {
        if let cellItem = item as? ImageTitleCellItem {
            print("\(#function) \(cellItem.title)")
            self.titleLbl.text = cellItem.title
        }
    }
}


class ImageTitleCellItem : SZTableViewItem {
    var title: String = ""
    
    override class var cellClass: AnyClass {
        return ImageTitleCell.self
    }
    override class func calcCellHeight() -> Float {
        return 80.0
    }
}

