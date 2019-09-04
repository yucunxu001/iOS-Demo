//
//  UseKVOViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/9/2.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UseKVOViewController: UIViewController {

    @IBOutlet weak var changeView: UIView!
    
    let disposeBag = DisposeBag()
    
    @objc dynamic var message = "hangge.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //监听基本类型的属性
        self.kvoDemo()
        
    }

    @IBAction func addFrame(_ sender: Any) {
        self.changeView.frame = CGRect(
            x: self.changeView.frame.origin.x,
            y: self.changeView.frame.origin.y,
            width: self.changeView.frame.size.width+20,
            height: self.changeView.frame.size.height+20)
        self.changeView.center = self.view.center
    }
    
    @IBAction func reduceFrame(_ sender: Any) {
        self.changeView.frame = CGRect(
            x: self.changeView.frame.origin.x,
            y: self.changeView.frame.origin.y,
            width: self.changeView.frame.size.width-20,
            height: self.changeView.frame.size.height-20)
        self.changeView.center = self.view.center
    }
    
    //监听基本类型的属性
    func kvoDemo() {
        /*
         监听的属性需要有 dynamic 修饰符。
         本样例需要使用 rx.observeWeakly，不能用 rx.observe，否则会造成循环引用，引起内存泄露。
         */
        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                self.message.append("!")
            }).disposed(by: disposeBag)
        //监听message变量的变化
        _ = self.rx.observeWeakly(String.self, "message")
            .subscribe(onNext: {(value) in
                print(value ?? "")
            })
        
        //监听changeView frame的改变
        _ = self.rx.observe(CGRect.self, "changeView.frame")
            .subscribe(onNext: { (frame) in
                print(frame as Any)
            })
    }

}
