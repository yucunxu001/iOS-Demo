//
//  SliderViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/26.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct UserViewModel {
    let username = BehaviorRelay(value: "guest")
    //用户信息
    lazy var userinfo = {
        return self.username.asObservable()
            .map { $0 == "admin" ? "您是管理员" : "您是普通访客" }
            .share(replay: 1)
    }()
}

class SliderViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    var userVM = UserViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        slider.rx.value.asObservable()
            .subscribe(onNext: { print("当前值：\($0)") })
            .disposed(by: disposeBag)
        
        stepper.rx.value.asObservable()
            .subscribe(onNext: { print("步进器值：\($0)") })
            .disposed(by: disposeBag)
        
//        将用户名与textField做双向绑定
//        userVM.username.asObservable().bind(to: textField.rx.text).disposed(by: disposeBag)
//        textField.rx.text.orEmpty.bind(to: userVM.username).disposed(by: disposeBag)

        //导入Operators.swift
        _ = textField.rx.textInput <-> userVM.username
        //将用户信息绑定到label上
        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)
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
