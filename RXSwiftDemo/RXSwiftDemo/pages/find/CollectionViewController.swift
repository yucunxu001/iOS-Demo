//
//  CollectionViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/27.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class CollectionViewController: UIViewController {

    var collectionView:UICollectionView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        //定义布局方式以及单元格大小
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 80)
        
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.backgroundColor = UIColor.gray
        self.view.addSubview(self.collectionView)
        
        //初始化数据源
        let items = Observable.just([
            "Swift",
            "Object-C",
            "PHP",
            "Ruby",
            "Java",
            "C++",
            ])
        
        //绑定数据源
        items.bind(to: collectionView.rx.items) {collectionView,row,element in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
            cell.lable.text = "第\(row)项：\n\(element)"
            cell.lable.numberOfLines = 0
            return cell
        }.disposed(by: disposeBag)
        
        //获取选中项的索引
        self.collectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("选择第\(indexPath.row)项")
        }).disposed(by: disposeBag)
        //获取选中项的内容
        self.collectionView.rx.modelSelected(String.self).subscribe(onNext: { item in
            print("\(item)")
        }).disposed(by: disposeBag)
        
        //如果想要同时获取选中项的索引，以及内容可以这么写：
        Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(String.self))
            .bind { [weak self] indexPath, item in
                print("选择第\(indexPath.row)项")
                print("\(item)")
            }
            .disposed(by: disposeBag)
        
        //获取被取消选中项的索引
        self.collectionView.rx.itemDeselected.subscribe(onNext: { [weak self] indexPath in
            print("取消选中\(indexPath.row)项")
        }).disposed(by: disposeBag)
        
        //获取被取消选中项的内容
        self.collectionView.rx.modelDeselected(String.self).subscribe(onNext: {[weak self] item in
            print("取消选中\(item)")
        }).disposed(by: disposeBag)
        Observable
            .zip(self.collectionView.rx.itemDeselected, self.collectionView.rx.modelDeselected(String.self))
            .bind { [weak self] indexPath, item in
                print("取消选中\(indexPath.row)项")
                print("取消选中\(item)")
            }
            .disposed(by: disposeBag)
        
        //获取选中并高亮完成后的索引
        self.collectionView.rx.itemHighlighted.subscribe(onNext: { indexPath in
            print("高亮单元格的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        //获取高亮转成非高亮完成后的索引
        self.collectionView.rx.itemUnhighlighted.subscribe(onNext: { indexPath in
            print("失去高亮的单元格的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        //单元格将要显示出来的事件响应
        self.collectionView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
            print("将要显示单元格indexPath为：\(indexPath)")
            print("将要显示单元格cell为：\(cell)\n")
        }).disposed(by: disposeBag)
        
//        //分区头部、尾部将要显示出来的事件响应
//        self.collectionView.rx.willDisplaySupplementaryView.subscribe(onNext: { view, kind, indexPath in
//            print("将要显示分区indexPath为：\(indexPath)")
//            print("将要显示的是头部还是尾部：\(kind)")
//            print("将要显示头部或尾部视图：\(view)\n")
//        }).disposed(by: disposeBag)
    }

}
