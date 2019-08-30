//
//  MoreCellTableViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/28.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MoreCellTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()

//    var dataSource:RxTableViewSectionedAnimatedDataSource<CustomSection>?
    var dataSource:RxTableViewSectionedAnimatedDataSource<MySection>?

    override func viewDidLoad() {
        super.viewDidLoad()

//        //初始化数据
//        let sections = Observable.just([
//            CustomSection(header: "我是第一个分区", items: [
//                .TitleImageSectionItem(title: "图片数据1", image: UIImage(named: "1")!),
//                .TitleImageSectionItem(title: "图片数据2", image: UIImage(named: "2")!),
//                .TitleSwitchSectionItem(title: "开关数据1", enabled: true),
//                .TitleSwitchSectionItem(title: "开关数据2", enabled: true),
//                ]),
//            CustomSection(header: "我是第二个分区", items: [
//                .TitleSwitchSectionItem(title: "开关数据3", enabled: false),
//                .TitleSwitchSectionItem(title: "开关数据4", enabled: false),
//                .TitleImageSectionItem(title: "图片数据3", image: UIImage(named: "3")!),
//                .TitleImageSectionItem(title: "图片数据4", image: UIImage(named: "4")!),
//                ])
//            ])
//
//        //创建数据源
//        let dataSource = RxTableViewSectionedAnimatedDataSource<CustomSection>(
//            //设置单元格
//            configureCell: { dataSource, tableView, indexPath, item in
//                switch dataSource[indexPath] {
//                case let .TitleImageSectionItem(title, image):
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "titleImageCell",
//                                                             for: indexPath)
//                    (cell.viewWithTag(1) as! UILabel).text = title
//                    (cell.viewWithTag(2) as! UIImageView).image = image
//                    return cell
//
//                case let .TitleSwitchSectionItem(title, enabled):
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "titleSwitchCell",
//                                                             for: indexPath)
//                    (cell.viewWithTag(1) as! UILabel).text = title
//                    (cell.viewWithTag(2) as! UISwitch).isOn = enabled
//                    return cell
//                }
//            },
//            //设置分区头标题
//            titleForHeaderInSection: { ds, index in
//                return ds.sectionModels[index].header
//            }
//        )
        
        
        //初始化数据
        let sections = Observable.just([
            MySection(header: "手机", items: ["Apple","华为","小米","OPPO","一佳","Vivo","魅族"]),
            MySection(header: "电脑", items: ["Apple","戴尔","华为","联想","弘基","神州","其他",])
            ])

        //创建数据源
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            //设置单元格
            configureCell: { ds, tv, ip, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")
                    ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
                cell.textLabel?.text = "\(ip.row)：\(item)"

                return cell
            },
            //设置分区尾部标题
            titleForFooterInSection: { ds, index in
                return "共有\(ds.sectionModels[index].items.count)个控件"
            }
        )

        
        self.dataSource = dataSource
        
        //绑定单元格数据
        sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        //设置代理
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

//tableView代理实现
extension MoreCellTableViewController : UITableViewDelegate {
    //设置单元格高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)
        -> CGFloat {
            guard let _ = dataSource?[indexPath],
                let _ = dataSource?[indexPath.section]
                else {
                    return 0.0
            }
            
            return 100
    }
}

////单元格类型
//enum CustomItem {
//    case TitleImageSectionItem(title: String, image: UIImage)
//    case TitleSwitchSectionItem(title: String, enabled: Bool)
//}
//
////自定义Section
//struct CustomSection {
//    var header: String
//    var items: [CustomItem]
//}
//
//extension CustomSection : SectionModelType {
//    typealias Item = CustomItem
//    init(original: CustomSection, items: [CustomItem]) {
//        self = original
//        self.items = items
//    }
//}

