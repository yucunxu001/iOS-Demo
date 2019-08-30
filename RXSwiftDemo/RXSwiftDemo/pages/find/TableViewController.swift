//
//  TableViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/27.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TableViewController: UIViewController {
    @IBOutlet weak var refreshBtn: UIBarButtonItem!
    @IBOutlet weak var cancleBtn: UIBarButtonItem!
    
    let disposeBag = DisposeBag()
    var tableView:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UITableView 和 RXSwift 的基本使用
//        self.baseTable()
        
        /*
         注意：RxDataSources 是以 section 来做为数据结构的。所以不管我们的 tableView 是单分区还是多分区，在使用 RxDataSources 的过程中，都需要返回一个 section 的数组。
         */
        //使用RxDataSources
//        self.useRxDataSources()
        //使用自定义的Section
//        self.customRxDataSources()
        //多个分区，使用自带的section
//        self.moreSection()
        //多个分区，自定义section
        self.customMoreSection()
        //刷新table
//        self.updateTable()
    }
    
    //UITableView 和 RXSwift 的基本使用
    func baseTable() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        self.view.addSubview(self.tableView)
        //初始化数据
        let items = Observable.just([
            "AAAAAAAAA",
            "BBBBBBBBB",
            "CCCCCCCCC",
            "DDDDDDDDD",
            "EEEEEEEEE",
            "FFFFFFFFF",
            ])
        //设置单元格数据（其实就是对 cellForRowAt 的封装）
        items.bind(to: tableView.rx.items) {(tableView,row,element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellId")!
            cell.textLabel?.text = "\(row)：\(element)"
            return cell
            }
            .disposed(by: disposeBag)
        
        //获取选中项的索引
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("选中项:\(indexPath.row)")
        }).disposed(by: disposeBag)
        //获取选中项的内容
        tableView.rx.modelSelected(String.self).subscribe(onNext: { item in
            print("选中项的标题为：\(item)")
        }).disposed(by: disposeBag)
        // 打开 cell 的编辑功能
        tableView.setEditing(true, animated: true)
        //获取被取消选中项的索引
        tableView.rx.itemDeselected.subscribe(onNext: { indexPath in
            print("取消选中项:\(indexPath.row)")
        }).disposed(by: disposeBag)
        //获取被取消选中项的内容
        tableView.rx.modelDeselected(String.self).subscribe(onNext: { item in
            print("获取被取消的标题为：\(item)")
        }).disposed(by: disposeBag)
        //获取删除项的索引
        tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            print("获取删除项的索引:\(indexPath)")
        }).disposed(by: disposeBag)
        //获取删除项的内容
        tableView.rx.modelDeleted(String.self).subscribe(onNext:{ item in
            print("获取删除项的内容:\(item)")
        }).disposed(by: disposeBag)
        //获取移动项的索引
        tableView.rx.itemMoved.subscribe(onNext: { sourceIndexPath, destinationIndexPath in
            print("移动项原来的indexPath为：\(sourceIndexPath)")
            print("移动项现在的indexPath为：\(destinationIndexPath)")
        }).disposed(by: disposeBag)
        //获取插入项的索引
        tableView.rx.itemInserted.subscribe(onNext: { indexPath in
            print("插入项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        //获取点击的尾部图标的索引
        tableView.rx.itemAccessoryButtonTapped.subscribe(onNext: { indexPath in
            print("尾部项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        //获取选中项的索引
        tableView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
            print("将要显示单元格indexPath为：\(indexPath)")
            print("将要显示单元格cell为：\(cell)\n")
        }).disposed(by: disposeBag)
    }
    
    // 方式一：使用自带的Section
    func useRxDataSources() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        self.view.addSubview(self.tableView)
        
        //初始化数据
        let items = Observable.just([SectionModel(model: "", items: ["苹果","香蕉","橘子","葡萄"])])
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,String>>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellId")!
                cell.textLabel?.text = "\(indexPath.row)：\(item)"
                return cell
        })
        //绑定数据源
        items.bind(to: tableView.rx.items(dataSource: dataSource) ).disposed(by: disposeBag)
        
    }
    
    //方式二：使用自定义的Section
    func customRxDataSources() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        self.view.addSubview(self.tableView!)
        
        let items = Observable.just([MySection(header: "", items: ["UILable的用法","UIText的用法","UIButton的用法"])])
        let data = RxTableViewSectionedReloadDataSource<MySection>(
            configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellId")!
            cell.textLabel?.text = "\(indexPath.row)：\(item)"
            return cell
        })
        items.bind(to: tableView.rx.items(dataSource: data)).disposed(by: disposeBag)
    }
    
    //多个sections使用自带的Section
    func moreSection() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        self.view.addSubview(self.tableView)
        
        let items = Observable.just([
            SectionModel(model: "手机", items: ["Apple","华为","小米","OPPO","一佳","Vivo","魅族"]),
            SectionModel(model: "电脑", items: ["Apple","戴尔","华为","联想","弘基","神州","其他",])
            ])
        let data = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellId")!
                cell.textLabel?.text = "\(indexPath.row):\(item)"
                return cell
        })
        //设置分区头标题
        data.titleForHeaderInSection = { dataSource,index in
            return dataSource.sectionModels[index].model
        }
        items.bind(to: tableView.rx.items(dataSource: data)).disposed(by: disposeBag)
        
    }
    //多个sections使用自定义Section
    func customMoreSection() {
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        let items = Observable.just([
            MySection(header: "手机", items: ["Apple","华为","小米","OPPO","一佳","Vivo","魅族"]),
            MySection(header: "电脑", items: ["Apple","戴尔","华为","联想","弘基","神州","其他",])
            ])
        let data = RxTableViewSectionedReloadDataSource<MySection>(
            configureCell: {dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(indexPath.row)：\(item)"
                return cell
        })
        data.titleForHeaderInSection = { dataSource,index in
            return dataSource.sectionModels[index].header
        }
        items.bind(to: tableView.rx.items(dataSource: data)).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: {  indexpath in
            print(indexpath)
        }).disposed(by: disposeBag)
    }
    //刷新table
    func updateTable() {
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        self.view.addSubview(self.tableView)
        
        //随机的表格数据
        let data = refreshBtn.rx.tap.asObservable()
            .throttle(1, scheduler: MainScheduler.instance) //在主线程中操作，1秒内值若多次改变，取最后一次
            .startWith(())
            .flatMapLatest{ self.getRandomResult().takeUntil(self.cancleBtn.rx.tap) }
            .share(replay: 1)
        //数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,Int>>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellID")!
                cell.textLabel?.text = "\(indexPath.row),\(item)"
                return cell
        })
        
        data.bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    //获取随机数据
    func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
        print("正在请求数据......")
        let items = (0 ..< 5).map {_ in
            Int(arc4random())
        }
        let observable = Observable.just([SectionModel(model: "S", items: items)])
        return observable.delay(2, scheduler: MainScheduler.instance)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//struct CustomData {
//    var anInt: Int
//    var aString: String
//    var aCGPoint: CGPoint
//}

//自定义Section
struct MySection {
    var header: String
    var items: [Item]
}

extension MySection : AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}
