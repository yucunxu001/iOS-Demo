//
//  RxPickerViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/29.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxPickerViewController: UIViewController {

    var pickerView:UIPickerView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建pickerView
        pickerView = UIPickerView()
        self.view.addSubview(pickerView)
        
        //绑定pickerView数据
        Observable.just([
            ["AAA", "BBB", "CCC", "DDD", "EEE", "FFF"],
            ["aaa","bbb","ccc","ddd","eee","fff"]
            ])
            .bind(to: pickerView.rx.items(adapter: stringPickerAdapter))
            .disposed(by: disposeBag)
        
        //建立一个按钮，触摸按钮时获得选择框被选择的索引
        let button = UIButton(frame:CGRect(x:0, y:0, width:100, height:30))
        button.center = self.view.center
        button.backgroundColor = UIColor.blue
        button.setTitle("获取信息",for:.normal)
        //按钮点击响应
        button.rx.tap
            .bind { [weak self] in
                self?.getPickerViewValue()
            }
            .disposed(by: disposeBag)
        self.view.addSubview(button)
        
    }
    
    //最简单的pickerView适配器（显示普通文本）
    private let stringPickerAdapter = RxPickerViewStringAdapter<[[String]]>(
        components: [],
        numberOfComponents: { dataSource,pickerView,components  in components.count },
        numberOfRowsInComponent: { (_, _, components, component) -> Int in
            return components[component].count},
        titleForRow: { (_, _, components, row, component) -> String? in
            return components[component][row]}
    )
    
    //触摸按钮时，获得被选中的索引
    @objc func getPickerViewValue(){
        let message = String(pickerView.selectedRow(inComponent: 0)) + "-" + String(pickerView.selectedRow(inComponent: 1))
        let alertController = UIAlertController(title: "被选中的索引为",message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    deinit {
        print(#file, #function)
    }
}
