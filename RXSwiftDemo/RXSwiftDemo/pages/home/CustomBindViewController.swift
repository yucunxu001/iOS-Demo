//
//  CustomBindViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/21.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CustomBindViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // 对 UILabel 进行扩展，增加了一个fontSize 可绑定属性
    @IBAction func changeFontSize(_ sender: Any) {
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observable
            .map { CGFloat($0) }
            .bind(to: label.fontSize)
            .disposed(by: disposeBag)
    }
    // 对 Reactive 类进行扩展
    @IBAction func changeFontSizeReactive(_ sender: Any) {
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
//        observable
//            .map { "索引==\($0)" }
//            .bind(to: label.rx.text)
//            .disposed(by: disposeBag)
        observable
            .map { CGFloat($0) }
            .bind(to: label.rx.fontSize)
            .disposed(by: disposeBag)
    }
    
}

extension UILabel {
    public var fontSize:Binder<CGFloat> {
        return Binder(self) { label,fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

extension Reactive where Base:UILabel {
    public var fontSize:Binder<CGFloat> {
        return Binder(self.base) { label ,fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
