//
//  URLSessionViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/29.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class URLSessionViewController: UIViewController {

    @IBOutlet weak var getBtn: UIButton!
    @IBOutlet weak var cancleBtn: UIButton!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         rx.data 与 rx.response 的区别：
         如果不需要获取底层的 response，只需知道请求是否成功，以及成功时返回的结果，那么建议使用 rx.data。
         因为 rx.data 会自动对响应状态码进行判断，只有成功的响应（状态码为 200~300）才会进入到 onNext 这个回调，否则进入 onError 这个回调。
         */
        
//        self.useRxData()
//        self.useRxResponse()
//        self.getDataClick()
        self.reqWithJson()
    }
    
    func reqWithJson() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)!
        let req = URLRequest(url: url)
        URLSession.shared.rx.json(request: req).subscribe(onNext: {data in
            let json = data as! [String: Any]
            print("--- 请求成功！返回的如下数据 ---")
            print(json )
        }).disposed(by: disposeBag)
    }
    
    func getDataClick() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)!
        let req = URLRequest(url: url)
        
        self.getBtn.rx.tap.asObservable()
            .flatMap {
                URLSession.shared.rx.data(request: req)
                .takeUntil(self.cancleBtn.rx.tap) //如果“取消按钮”点击则停止请求
            }
            .subscribe(onNext: {data in
                let jsonString = String(data: data, encoding: String.Encoding.utf8)
                print("请求成功！返回的数据是：", jsonString ?? "")
            },onError:{ error in
                print("请求失败！错误原因：", error)
            }).disposed(by: disposeBag)
        
    }

    
    func useRxResponse() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)!
        let req = URLRequest(url: url)
        //创建并发起请求
        //创建并发起请求
        URLSession.shared.rx.response(request: req).subscribe(onNext: {(response, data) in
            //数据处理
            let jsonString = String(data: data, encoding: String.Encoding.utf8)
            print(jsonString ?? "")
            //            print(self.nsdataToJSON(data: data) ?? nil)
        }).disposed(by: disposeBag)
    }
    
    func useRxData() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)!
        let req = URLRequest(url: url)
        //创建并发起请求
        URLSession.shared.rx.data(request: req).subscribe(onNext: {
            data in
            let jsonString = String(data: data, encoding: String.Encoding.utf8)
            print("请求成功！返回的数据是：", jsonString ?? "")
        },onError: {error in
            print(error)
        }).disposed(by: disposeBag)
    }
    
    // Data转Json
    func nsdataToJSON(data: Data) -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as AnyObject
        } catch {
            print(error)
        }
        return nil
    }
    

}
