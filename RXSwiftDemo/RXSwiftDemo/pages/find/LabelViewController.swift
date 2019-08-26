//
//  LabelViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/26.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LabelViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startBtnClick(_ sender: Any) {
        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
        
        // 将数据绑定到 text 属性上
//        timer.map { String(format: "%0.2d:%0.2d.%0.1d",
//                          arguments: [($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10]) }
//            .bind(to: label.rx.text)
//            .disposed(by: disposeBag)
        
        
        //将数据绑定到 attributedText 属性上（富文本）
        timer.map(formatTimeInterval).bind(to: label.rx.attributedText).disposed(by: disposeBag)
    }
    
    func formatTimeInterval(ms:NSInteger) -> NSMutableAttributedString {
        let time = String(format: "%0.2d:%0.2d.%0.1d",
                            arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
        //富文本设置
        let attributeString = NSMutableAttributedString(string: time)
        //设置字体大小
        attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 16), range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 24), range: NSMakeRange(0, 3))
        attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(3, 3))
        //设置字体颜色
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: NSMakeRange(0, 3))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.yellow, range: NSMakeRange(3, 3))
        //设置文字背景颜色
        attributeString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.gray, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.orange, range: NSMakeRange(0, 3))
        attributeString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.blue, range: NSMakeRange(3, 3))
        
        return attributeString
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
