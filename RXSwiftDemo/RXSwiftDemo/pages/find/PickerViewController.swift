//
//  PickerViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/27.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PickerViewController: UIViewController {

    @IBOutlet weak var timeLb: UILabel!

    //日期格式化器
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        return formatter
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showDataPicker(_ sender: Any) {
//        dataPicker.rx.date.map { [weak self] in
//            "当前选择时间: " + self!.dateFormatter.string(from: $0)
//        }.bind(to: timeLb.rx.text)
//        .disposed(by: disposeBag)
        
        let picker = UIDatePicker(frame: CGRect(x: 0, y: self.view.frame.size.height-300, width: self.view.frame.size.width, height: 300));
        picker.backgroundColor = .green // 设置背景颜色
        picker.datePickerMode = .dateAndTime
        picker.locale = Locale(identifier: "zh_CN") // 将日期选择器区域设置为中文（默认显示英文）
        picker.minuteInterval = 5 // 时间分钟间隔设置
//        picker.minimumDate = Date(timeInterval: -93312000, since: Date())
//        picker.maximumDate = Date(timeInterval: 93312000, since: Date())
        picker.setDate(Date(), animated: true) // 设置默认时间
        self.view.addSubview(picker)
        
        picker.rx.date
            .map { [weak self] in
                "选择时间: " + self!.dateFormatter.string(from: $0)
            }
            .bind(to: timeLb.rx.text)
            .disposed(by: disposeBag)
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
