//
//  TextFieldViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/26.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TextFieldViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bindField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //注意：.orEmpty 可以将 String? 类型的 ControlProperty 转成 String，省得我们再去解包。
//        textField.rx.text.orEmpty.asObservable()
//            .subscribe(onNext: {
//                print("你输入：\($0)")
//                self.label1.text = $0
//            })
//            .disposed(by: disposeBag)
        
//        /*直接使用 change 事件效果也是一样*/
//        textField.rx.text.orEmpty.changed
//            .subscribe(onNext: {
//                print("你输入：\($0)")
//                self.label1.text = $0
//            })
//            .disposed(by: disposeBag)
        
        
//        //当文本框内容改变
//        /*将普通序列转换为 Driver,在主线程中操作，0.2秒内值若多次改变，取最后一次*/
//        let input = textField.rx.text.orEmpty.asDriver().throttle(0.2)
//        //内容绑定到另一个输入框中
//        input.drive(bindField.rx.text).disposed(by: disposeBag)
//        //内容绑定到文本标签中
//        input.map{"文本内容：\($0)"}.drive(label1.rx.text).disposed(by: disposeBag)
        
        //同时监听多个 textField 内容的变化
        Observable.combineLatest(textField.rx.text.orEmpty, bindField.rx.text.orEmpty) { (value1, value2) -> String in
            return "输入\(value1),\(value2)"
            }
            .bind(to: label1.rx.text)
            .disposed(by: disposeBag)
        
        /*
         rx.controlEvent 可以监听输入框的各种事件，且多个事件状态可以自由组合。除了各种 UI 控件都有的 touch 事件外，输入框还有如下几个独有的事件：
         editingDidBegin：开始编辑（开始输入内容）
         editingChanged：输入内容发生改变
         editingDidEnd：结束编辑
         editingDidEndOnExit：按下 return 键结束编辑
         allEditingEvents：包含前面的所有编辑相关事件
         */
        textField.rx.controlEvent([.editingDidBegin])
            .asObservable()
            .subscribe(onNext: { print("editingDidBegin") })
            .disposed(by: disposeBag)
        textField.rx.controlEvent([.editingDidEndOnExit])
            .subscribe(onNext: { [weak self] (_) in
                self?.textField.resignFirstResponder()
            })
        
        /*
         UITextView 还封装了如下几个委托回调方法：
         didBeginEditing：开始编辑
         didEndEditing：结束编辑
         didChange：编辑内容发生改变
         didChangeSelection：选中部分发生变化
         */
        
        textView.rx.didBeginEditing
            .subscribe(onNext: { print("开始编辑") })
            .disposed(by: disposeBag)
        textView.rx.didEndEditing
            .subscribe(onNext: { print("结束编辑") })
            .disposed(by: disposeBag)
        textView.rx.didChange
            .subscribe(onNext: { print("内容发生改变") })
            .disposed(by: disposeBag)
        textView.rx.didChangeSelection
            .subscribe(onNext: {
                print("选中部分发生变化")
            })
            .disposed(by: disposeBag)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
