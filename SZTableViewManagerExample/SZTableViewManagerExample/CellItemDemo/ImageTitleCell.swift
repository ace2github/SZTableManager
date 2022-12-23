//
//  ImageTitleCell.swift
//  SZTableViewManagerExample
//
//  Created by Hui on 2022/12/9.
//

import Foundation
import SZTableViewManager
import SnapKit

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
            self.iconImgV.snp.makeConstraints { make in
                make.size.equalTo(CGSize.init(width: 50, height: 50))
                make.centerY.equalTo(self.contentView)
                make.leading.equalTo(self.contentView).offset(15)
            }

            self.titleLbl.frame = CGRect(x: 60, y: 5, width: 150, height: 20)
            self.contentView.addSubview(self.titleLbl)
            self.titleLbl.snp.makeConstraints { (make) in
                make.leading.equalTo(self.iconImgV.snp.trailing).offset(10.0)
                make.centerY.equalTo(self.contentView)
            }
        }
    }

    override func didUpdate(_ item: SZTableViewItem?) {
        if let cellItem = item as? ImageTitleCellItem {
            print("\(#function) \(cellItem.title)")
            self.titleLbl.text = cellItem.title
        }
    }
    
    // cell will display
    override func willAppear(_ item: SZTableViewItem?) {
        
    }
    // cell did end display
    override func didDisappear(_ item: SZTableViewItem?) {
        
    }
}


class ImageTitleCellItem : SZTableViewItem {
    var title: String = ""
    
    override class var cellClass: AnyClass {
        return ImageTitleCell.self
    }
    override func calcCellHeight() -> Float {
        return 80.0
    }
}

