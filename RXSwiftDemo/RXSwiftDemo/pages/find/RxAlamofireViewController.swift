//
//  RxAlamofireViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/30.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
class RxAlamofireViewController: UIViewController {

    @IBOutlet weak var getDataBtn: UIButton!
    
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getDataBtn.rx.tap.asObservable().subscribe(onNext: {
            print("请求数据")
            //创建URL对象
            let urlString = "https://www.douban.com/j/app/radio/channels"
            let url = URL(string:urlString)!
            //创建并发起请求
            AF.request(url).responseJSON { (response) in
                
                //            print(response.request as Any)  // original URL request
                //            print(response.response as Any) // URL response
                //            print(response.data)     // server data
                print(response.result)   // result of response serialization
            }
//            AF.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Encodable?#>, encoder: <#T##ParameterEncoder#>, headers: <#T##HTTPHeaders?#>, interceptor: <#T##RequestInterceptor?#>)
//            AF.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>, interceptor: <#T##RequestInterceptor?#>)

        }).disposed(by: disposeBag)
        

    }

}
