//
//  MemoryViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/29.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MemoryViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         如果捕获（比如 self）可以被设置为 nil，也就是说它可能在闭包前被销毁，那么就要将捕获定义为 weak。
         如果它们一直是相互引用，即同时销毁的，那么就可以将捕获定义为 unowned。
         */
        textField.rx.text.orEmpty.asDriver().drive(onNext: {
            [weak self] text in
            DispatchQueue.main.asyncAfter(deadline: .now()+4, execute: {
                print("当前输入内容：\(String(describing: text))")
                self?.label.text = text
            })
        }).disposed(by: disposeBag)
        
    }
    
    deinit {
        print(#file, #function)
    }
}
