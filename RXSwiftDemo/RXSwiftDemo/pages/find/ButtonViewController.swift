//
//  ButtonViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/26.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ButtonViewController: UIViewController {

    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    
    let  disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.green
        //按钮点击响应 //第一种
//        firstBtn.rx.tap
//            .subscribe(onNext: { [weak self] in
//                self?.showMessage(type: 2)
//            })
//            .disposed(by: disposeBag)
        
        //第二种
//        firstBtn.rx.tap
//            .bind {[weak self] in
//                self?.showMessage(type: 2)
//            }
//            .disposed(by: disposeBag)
        
//        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        timer.map { "计时：\($0)" }
//            .bind(to: firstBtn.rx.title(for: .normal))
//            .disposed(by: disposeBag)
        
        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        timer.map(mutableString)
            .bind(to: firstBtn.rx.attributedTitle())
            .disposed(by: disposeBag)
        
        
        button1.isSelected = true
        
        let buttons = [button1, button2, button3].map { $0! }
        //创建一个可观察序列，它可以发送最后一次点击的按钮（也就是我们需要选中的按钮）
        let selectedButton = Observable.from(
            buttons.map { button in button.rx.tap.map { button } }
            ).merge()
        //每一个按钮都对selectedButton进行订阅，根据它是否是当前选中的按钮绑定isSelected属性
        for button in buttons {
            selectedButton.map { $0 == button }
                .bind(to: button.rx.isSelected)
                .disposed(by: disposeBag)
        }
        
//        switch1.rx.isOn.asObservable()
//            .subscribe(onNext: {
//                print("开关：\($0)")
//            })
//            .disposed(by: disposeBag)
        
//        switch1.rx.isOn.bind(to: startBtn.rx.isEnabled).disposed(by: disposeBag)
        
//        segment.rx.selectedSegmentIndex.asObservable()
//            .subscribe(onNext: { print("当前项：\($0)") })
//            .disposed(by: disposeBag)
        
        let showImgObs:Observable<UIImage> = segment.rx.selectedSegmentIndex.asObservable().map {
            let images = ["1","2","3","4"]
            return UIImage(named: images[$0])!
        }
        showImgObs.bind(to: imageView.rx.image).disposed(by: disposeBag)
        
        
    }
    @IBAction func start(_ sender: Any) {
        print("哈哈哈哈哈哈哈哈")
    }
    
    func showMessage(type:NSInteger) {
        print(type)
        if type == 1 {
            let alert = UIAlertController(title: "标题", message: "内容哈哈哈", preferredStyle: .alert)
            let cancle = UIAlertAction(title: "取消", style: .cancel) { (AlertAction) in
                print("取消")
            }
            let query = UIAlertAction(title: "确定", style: .default) { (AlertAction) in
                print("确定")
            }
            alert.addAction(cancle)
            alert.addAction(query)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let actionSheet = UIAlertController(title: "标题", message: "哈哈哈哈哈哈哈", preferredStyle: .actionSheet)
            let action1 = UIAlertAction(title: "相机", style: .default) { (action) in
                print("相机")
            }
            let action2 = UIAlertAction(title: "相册", style: .default) { (action) in
                print("相册")
            }
            let cancle = UIAlertAction(title: "取消", style: .cancel) { (action) in
                print("取消")
            }
            actionSheet.addAction(action1)
            actionSheet.addAction(action2)
            actionSheet.addAction(cancle)
            self.present(actionSheet, animated: true, completion: nil)
            
        }
    }
    
    func mutableString(ms:NSInteger) -> NSMutableAttributedString {
        let att = NSMutableAttributedString(string: "\(ms)")
        att.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(0, att.length))
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSMakeRange(0, att.length))
        return att
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
