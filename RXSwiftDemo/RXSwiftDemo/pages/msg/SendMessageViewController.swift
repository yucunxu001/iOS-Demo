//
//  SendMessageViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/9/4.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SendMessageViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2222222")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         sentMessage 会在调用方法前发送值。
         methodInvoked 会在调用方法后发送值。
         */
        self.rx.sentMessage(#selector(SendMessageViewController.viewWillAppear(_:)))
            .subscribe(onNext: {value in
                print("1111")
            }).disposed(by: disposeBag)
        
        self.rx.methodInvoked(#selector(SendMessageViewController.viewWillAppear(_:)))
            .subscribe(onNext: {value in
                print("333333")
            }).disposed(by: disposeBag)
        
    }

}
