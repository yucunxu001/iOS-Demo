//
//  RxDataCollectionViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/29.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxDataCollectionViewController: UIViewController {

    var collectionView:UICollectionView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         RxDataSources 是以 section 来做为数据结构的。所以不管我们的 collectionView 是单分区还是多分区，在使用 RxDataSources 的过程中，都需要返回一个 section 的数组
         */
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.headerReferenceSize = CGSize(width: self.view.frame.size.width, height: 50)

        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        self.collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        self.collectionView.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)

        let items = Observable.just([
            MyDataModel(title: "编程语言", items: ["OC","Swift","Vue","ReactNative","小程序","Html"]),
            MyDataModel(title: "工具", items: ["Xcode","AppCode","VSCode","Android","微信开发工具","sumline"]),
            MyDataModel(title: "手机", items: ["Apple","华为","小米","vivo","oppo","一加","其他"]),
            MyDataModel(title: "位置", items: ["上海","北京","深圳","广州","重庆","成都"]),
            ])

        let data = RxCollectionViewSectionedReloadDataSource<MyDataModel>(
            configureCell: {dataSource,collectionView,indexPath,element in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CustomCollectionViewCell
                cell.lable.text = "\(element)"
                return cell
            },
            configureSupplementaryView: {dataSource,collectionView,kind,indexPath in
                print(kind)
                print(indexPath)
                print(dataSource[indexPath.section].title)

                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderView
                header.label.text = "\(dataSource[indexPath.section].title)"
                return header
            }
        )
        items.bind(to: collectionView.rx.items(dataSource: data)).disposed(by: disposeBag)
        
        self.collectionView.rx.willDisplaySupplementaryView.subscribe(onNext: { view, kind, indexPath in
            print("将要显示分区indexPath为：\(indexPath)")
            print("将要显示的是头部还是尾部：\(kind)")
            print("将要显示头部或尾部视图：\(view)\n")

        }).disposed(by: disposeBag)
        
        //设置代理
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension RxDataCollectionViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 30) / 4 //每行显示4个单元格
        return CGSize(width: cellWidth, height: cellWidth * 1.5) //单元格宽度为高度1.5倍
    }
}



struct MyDataModel {
    var title: String
    var items: [Item]
}

extension MyDataModel : AnimatableSectionModelType {
    typealias Item = String
    var identity: String {
        return title
    }
    init(original: MyDataModel, items: [Item]) {
        self = original
        self.items = items
    }
}
