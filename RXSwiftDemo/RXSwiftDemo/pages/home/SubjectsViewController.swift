//
//  SubjectsViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/21.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SubjectsViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func publish(_ sender: Any) {
        /*
         PublishSubject是最普通的 Subject，它不需要初始值就能创建。
         PublishSubject 的订阅者从他们开始订阅的时间点起，可以收到订阅后 Subject 发出的新 Event，而不会收到他们在订阅前已发出的 Event
         */
        // 创建一个PublishSubject
        let sub = PublishSubject<String>()
        // 由于当前没有任何订阅者，所以这条信息不会输出到控制台
        sub.onNext("111")
        //第1次订阅sub
        sub.subscribe(onNext: { (text) in
            print("第一次订阅\(text)")
        }, onError: { (error) in
            print("第一次订阅\(error)")
        }, onCompleted: {
            print("第一次订阅onCompleted")
        }) {
            print("第一次订阅dispose")
        }
        //当前有1个订阅，则该信息会输出到控制台
        sub.onNext("222")
        // 第二次订阅
        sub.subscribe(onNext: { (text) in
            print("第二次订阅\(text)")
        }, onError: { (error) in
            print("第二次订阅\(error)")
        }, onCompleted: {
            print("第二次订阅onCompleted")
        }) {
            print("第二次订阅dispose")
        }
        // 当前有两个订阅，则该信息会输出到控制台
        sub.onNext("333")
        // 让subject结束
        sub.onCompleted()
        // sub完成后会不会发出.next事件了
        sub.onNext("444")
        //sub完成后它的所有订阅（包括结束后的订阅），都能收到subject的.completed事件，
        sub.subscribe(onNext: { (text) in
            print("第三次订阅\(text)")
        }, onError: { (error) in
            print("第三次订阅\(error)")
        }, onCompleted: {
            print("第三次订阅onCompleted")
        }) {
            print("第三次订阅dispose")
        }
        //
        sub.onNext("555")
    }
    
    @IBAction func behavior(_ sender: Any) {
        /*
         BehaviorSubject 需要通过一个默认初始值来创建。
         当一个订阅者来订阅它的时候，这个订阅者会立即收到 BehaviorSubjects 上一个发出的event。之后就跟正常的情况一样，它也会接收到 BehaviorSubject 之后发出的新的 event。
         */
        //创建一个BehaviorSubject
        let behav = BehaviorSubject<String>(value: "111")
        //第1次订阅subject
        behav.subscribe(onNext: { (text) in
            print("behav第一次订阅\(text)")
        }, onError: { (error) in
            print("behav第一次订阅\(error)")
        }, onCompleted: {
            print("behav第一次订阅onCompleted")
        }) {
            print("behav第一次订阅dispose")
        }
        //发送next事件
        behav.onNext("222")
        //发送error事件，之后就不在执行.next事件了
        behav.onError(NSError(domain: "local", code: 0, userInfo: nil))
        //第2次订阅subject
        behav.subscribe(onNext: { (text) in
            print("behav第二次订阅\(text)")
        }, onError: { (error) in
            print("behav第二次订阅\(error)")
        }, onCompleted: {
            print("behav第二次订阅onCompleted")
        }) {
            print("behav第二次订阅dispose")
        }
    }
    
    @IBAction func replay(_ sender: Any) {
        /*
         ReplaySubject 在创建时候需要设置一个 bufferSize，表示它对于它发送过的 event 的缓存个数。
         比如一个 ReplaySubject 的 bufferSize 设置为 2，它发出了 3 个 .next 的 event，那么它会将后两个（最近的两个）event 给缓存起来。此时如果有一个 subscriber 订阅了这个 ReplaySubject，那么这个 subscriber 就会立即收到前面缓存的两个.next 的 event。
         如果一个 subscriber 订阅已经结束的 ReplaySubject，除了会收到缓存的 .next 的 event外，还会收到那个终结的 .error 或者 .complete 的event
         */
        //创建一个bufferSize为2的ReplaySubject
        let replay = ReplaySubject<String>.create(bufferSize: 2)
        replay.onNext("111")
        replay.onNext("222")
        replay.onNext("333")
        replay.subscribe(onNext: { (text) in
            print("replay第一次订阅\(text)")
        }, onError: { (error) in
            print("replay第一次订阅\(error)")
        }, onCompleted: {
            print("replay第一次订阅onCompleted")
        }) {
            print("replay第一次订阅dispose")
        }
        //再发送1个next事件
        replay.onNext("444")
        replay.subscribe(onNext: { (text) in
            print("replay第二次订阅\(text)")
        }, onError: { (error) in
            print("replay第二次订阅\(error)")
        }, onCompleted: {
            print("replay第二次订阅onCompleted")
        }) {
            print("replay第二次订阅dispose")
        }
        //让replay结束
        replay.onCompleted()
        //第3次订阅replay
        replay.subscribe(onNext: { (text) in
            print("replay第三次订阅\(text)")
        }, onError: { (error) in
            print("replay第三次订阅\(error)")
        }, onCompleted: {
            print("replay第三次订阅onCompleted")
        }) {
            print("replay第三次订阅dispose")
        }
    }
    
    @IBAction func variable(_ sender: Any) {
        /*
         Variable 其实就是对 BehaviorSubject 的封装，所以它也必须要通过一个默认的初始值进行创建。
         Variable 具有 BehaviorSubject 的功能，能够向它的订阅者发出上一个 event 以及之后新创建的 event。
         不同的是，Variable 还会把当前发出的值保存为自己的状态。同时它会在销毁时自动发送 .complete的 event，不需要也不能手动给 Variables 发送 completed或者 error 事件来结束它。
         简单地说就是 Variable 有一个 value 属性，我们改变这个 value 属性的值就相当于调用一般 Subjects 的 onNext() 方法，而这个最新的 onNext() 的值就被保存在 value 属性里了，直到我们再次修改它。
         */
        
        //创建一个初始值为111的Variable
        let variable = Variable("111")
        //修改value值
        variable.value = "222"
        //第1次订阅
        variable.asObservable().subscribe {
            print("第1次订阅：", $0)
            }.disposed(by: disposeBag)
        //修改value值
        variable.value = "333"

        //第2次订阅
        variable.asObservable().subscribe {
            print("第2次订阅：", $0)
            }.disposed(by: disposeBag)

        //修改value值
        variable.value = "444"
        /*
         由于 Variable对象在variable() 方法内初始化，所以它的生命周期就被限制在该方法内。当这个方法执行完毕后，这个 Variable 对象就会被销毁，同时它也就自动地向它的所有订阅者发出.completed 事件
         */
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
