//
//  NotificationViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/9/2.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NotificationViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //进入后台
        self.DidEnterBackground()
        // APP进入前台
        self.EnterForeground()
        // 监听键盘弹起或消失
        self.addKeyboardNOtification()
        // 注册自定义通知
        self.customNotification()
    }
    
    // 进入后台
    func DidEnterBackground() {
        /*
         .takeUntil(self.rx.deallocated)：
         它的作用是保证页面销毁的时候自动移除通知注册，避免内存浪费或奔溃
         */
        _ = NotificationCenter.default.rx
            .notification(UIApplication.didEnterBackgroundNotification)
            .takeUntil(self.rx.deallocated)//页面销毁自动移除通知监听
            .subscribe(onNext: {_ in
                print("app进入后台")
            })
    }
    
    // APP进入前台
    func EnterForeground() {
        _ = NotificationCenter.default.rx
            .notification(UIApplication.willEnterForegroundNotification)
            .takeUntil(self.rx.deallocated)//页面销毁自动移除通知监听
            .subscribe(onNext: {_ in
                print("app进入前台")
            })
    }
    
    //监听键盘弹起或消失
    func addKeyboardNOtification() {
        //点击键盘上的完成按钮后，收起键盘
        textField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: {  _ in
                //收起键盘
                self.textField.resignFirstResponder()
                print("editingDidEnd 键盘消失")
            })
            .disposed(by: disposeBag)
        // 键盘出现
        _ = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { _ in
                print("键盘出现")
            })
        // 键盘消失
        _ = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: {_ in
                print("键盘消失")
            })
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
    // 自定义通知
    func customNotification() {
        let notificationName = NSNotification.Name(rawValue: "CustomNotification")
        _ = NotificationCenter.default.rx
            .notification(notificationName)
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { notification in
                print("收到")
                let userInfo = notification.userInfo as! [String: AnyObject]
                let value1 = userInfo["value1"] as! String
                let value2 = userInfo["value2"] as! String
                print("value1==\(value1)")
                print("value2==\(value2)")
            })
        
    }
    @IBAction func sendCustomNotification(_ sender: Any) {
        print("发送")
        let notificationName = NSNotification.Name(rawValue: "CustomNotification")
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: ["value1":"admin","value2":"123456",])
    }
    
}
