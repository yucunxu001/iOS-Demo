//
//  EditTableViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/28.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

//使用 enum 创建一个命令枚举，里面定义了对 tableView 数据的各种操作
enum TableEditingCommand {
    case setItems(items:[String]) // 设置table数据
    case addItem(item:String) // 新增数据
    case moveItem(from:IndexPath,to:IndexPath) //移动
    case deleteItem(IndexPath) // 删除
}

//定义 tableView 对应的 ViewModel,除了保存有表格数据外，还包含上面定义的 4 个操作命令的具体实现。
struct TableViewModel {
    //表格数据项
    fileprivate var items:[String]
    
    init(items: [String] = []) {
        self.items = items
    }
    //执行相应的命令，并返回最终的结果
    func execute(commend:TableEditingCommand) -> TableViewModel {
        switch commend {
        case .setItems(let items):
            print("设置表格数据。")
            return TableViewModel(items: items)
        case .addItem(let item):
            print("新增数据项")
            var items = self.items
            items.append(item)
            return TableViewModel(items: items)
        case .moveItem(let from, let to):
            print("移动数据项")
            var items = self.items
            items.insert(items.remove(at: from.row), at: to.row)
            return TableViewModel(items: items)
        case .deleteItem(let indexPath):
            print("删除数据项")
            var items = self.items
            items.remove(at: indexPath.row)
            return TableViewModel(items: items)
        }
    }
}

class EditTableViewController: UIViewController {

    @IBOutlet weak var refreshBtn: UIBarButtonItem!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    var tableView:UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "编辑UITableView"
        
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        self.tableView.setEditing(true, animated: true)
        
        //表格模型
        let initialVM = TableViewModel()
        
        //刷新数据命令
        let refreshCommand = refreshBtn.rx.tap.asObservable()
            .startWith(())
            .flatMapLatest(getData)
            .map(TableEditingCommand.setItems)
        //添加命令
        let addCommand = addBtn.rx.tap.asObservable()
            .map {"\(arc4random())"}
            .map(TableEditingCommand.addItem)
        //移动命令
        let moveCommand = self.tableView.rx.itemMoved
            .map(TableEditingCommand.moveItem)
        //删除命令
        let deleteCommand = self.tableView.rx.itemDeleted
            .map(TableEditingCommand.deleteItem)
        
        //绑定单元格数据
        Observable.of(refreshCommand,addCommand,moveCommand,deleteCommand)
            .merge()
            .scan(initialVM) { (vm:TableViewModel, command:TableEditingCommand) -> TableViewModel in
                return vm.execute(commend: command)
            }
            .startWith(initialVM)
            .map {
                [AnimatableSectionModel(model: "", items: $0.items)]
            }
            .share(replay: 1)
            .bind(to: tableView.rx.items(dataSource: EditTableViewController.dataSource()))
            .disposed(by: disposeBag)
    }
    
    //获取随机数据
    func getData() -> Observable<[String]> {
        print("生成随机数据。")
        let items = (0 ..< 5).map { _ in
            "\(arc4random())"
        }
        return Observable.just(items)
    }

}

extension EditTableViewController {
    //创建表格数据源
    static func dataSource() -> RxTableViewSectionedAnimatedDataSource
        <AnimatableSectionModel<String, String>> {
            return RxTableViewSectionedAnimatedDataSource(
                //设置插入、删除、移动单元格的动画效果
                animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                               reloadAnimation: .fade,
                                                               deleteAnimation: .left),
                configureCell: {
                    (dataSource, tv, indexPath, element) in
                    let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                    cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
                    return cell
                },
                canEditRowAtIndexPath: { _, _ in
                    return true //单元格可删除
                },
                canMoveRowAtIndexPath: { _, _ in
                    return true //单元格可移动
                }
            )
    }
}
