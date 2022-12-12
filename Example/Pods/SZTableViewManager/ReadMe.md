
### 概述
RETableViewManager 的 Swift 版本
之前的项目使用RETableViewManager，在构建基于UITableView的列表页面时候，可以做到极大的复用和快速渲染

* 核心理念：数据驱动

### 实践
* 0、理论 item-cell 是一一对应的关系 


* 1、Tableview的移动和删除逻辑（tbd）
* 2、UITableViewDelegate的外部代理出去（tbd）


### 实践
1、自定义 `SZTableViewCell` 和 `SZTableViewItem` 的子类
```
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
    
    // 加载一次，cell创建
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

    // cell数据的更新
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
    
    // 返回对应的cell
    override class var cellClass: AnyClass {
        return ImageTitleCell.self
    }
    // 返回Cell的高度
    override class func calcCellHeight() -> Float {
        return 80.0
    }
}

```

2、创建Manager
```
// ViewController
lazy var tableview: UITableView = {
    let tblV = UITableView(frame:self.view.bounds, style:.plain)
    return tblV
}()


// manager
let tblManager: SZTableViewManager = SZTableViewManager()
self.view.addSubview(self.tableview)

// 关联tableview
tblManager.bindTableView(self.tableview)
tblManager.registerList([
    SZTitleCellItem.self,
    ImageTitleCellItem.self
])

// 创建section
let section: SZTableViewSection = SZTableViewSection.init()

let item = SZTitleCellItem()
item.title = "TitleCell \(i)"
item.action.selected = { (_ vi: SZTableViewItem? ,_ tblMgr: SZTableViewManager) in
    if let cellItem = vi as? SZTitleCellItem {
        print("click: \(cellItem.title)")
    }
}
section.addItem(item)

tblManager.addSection(section)
```
