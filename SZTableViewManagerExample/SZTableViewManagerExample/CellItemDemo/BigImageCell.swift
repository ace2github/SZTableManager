//
//  BigImageCell.swift
//  SZTableViewManagerExample
//
//  Created by Hui on 2022/12/9.
//

import Foundation
import SZTableViewManager
import SnapKit

class BigImageCell: SZTableViewCell {
    lazy var bigImgV: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage.init(named: "facebook")
        imgV.clipsToBounds = true
        return imgV
    }()
    
    override func didLoad(_ item: SZTableViewItem?) {
        super.didLoad(item)
        if item is BigImageCellItem {
            self.contentView.addSubview(self.bigImgV)
            self.bigImgV.snp.makeConstraints { make in
                make.leading.top.equalTo(self.contentView).offset(15)
                make.trailing.bottom.equalTo(self.contentView).offset(-15)
            }
        }
    }

    override func didUpdate(_ item: SZTableViewItem?) {
        if let cellItem = item as? BigImageCellItem {
            print("\(#function) \(cellItem.url)")
            self.bigImgV.image = UIImage.init(named: cellItem.url)
        }
    }
    
    // cell will display
    override func willAppear(_ item: SZTableViewItem?) {
        
    }
    // cell did end display
    override func didDisappear(_ item: SZTableViewItem?) {
        
    }
}


class BigImageCellItem : SZTableViewItem {
    var url: String = ""
    
    override class var cellClass: AnyClass {
        return BigImageCell.self
    }
    override class func calcCellHeight() -> Float {
        return 200
    }
}
