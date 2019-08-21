//
//  ObservableViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/19.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ObservableViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    // 该方法通过传入一个默认值来初始化
    let justObs = Observable<Int>.just(10)
    // 该方法可以接受可变数量的参数（必需要是同类型的）
    let ofObs = Observable.of("A","B","C")
    // 该方法需要一个数组参数
    let fromObs = Observable.from(["A","B","C","D",])
    // 该方法创建一个空内容的 Observable 序列。
    let emptyObs = Observable<Int>.empty()
    // 该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列。
    let neverObs = Observable<Int>.never()
    // 该方法创建一个不做任何操作，而是直接发送一个错误的 Observable 序列。
    enum MyError: Error {
        case A
        case B
    }
    let errorObs = Observable<Int>.error(MyError.A)
    // 该方法通过指定起始和结束数值，创建一个以这个范围内所有值作为初始值的Observable序列。
    let rangeObs = Observable.range(start: 1, count: 5)
    // 该方法创建一个可以无限发出给定元素的 Event的 Observable 序列（永不终止）。
    let repeatElementObs = Observable.repeatElement(1)
    // 该方法创建一个只有当提供的所有的判断条件都为 true 的时候，才会给出动作的  Observable 序列。
    let generateObs = Observable.generate(
        initialState: 0,
        condition: {$0 <= 10},
        iterate: {$0 + 2})
    // 该方法接受一个 block 形式的参数，任务是对每一个过来的订阅进行处理
    let createObs = Observable<String>.create { (observer) -> Disposable in
        //对订阅者发出了.next事件，且携带了一个数据"hangge.com"
        observer.onNext("hangge.com")
        //对订阅者发出了.completed事件
        observer.onCompleted()
        //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
        return Disposables.create()
    }
    // 该个方法相当于是创建一个 Observable 工厂，通过传入一个 block 来执行延迟 Observable序列创建的行为，而这个 block 里就是真正的实例化序列对象的地方
    //用于标记是奇数、还是偶数
    var isOdd = true

    // 这个方法创建的 Observable 序列每隔一段设定的时间，会发出一个索引数的元素。而且它会一直发送下去
    let intervalObs = Observable<Int>.interval(3, scheduler: MainScheduler.instance)
    // 这个方法有两种用法，一种是创建的 Observable序列在经过设定的一段时间后，产生唯一的一个元素。
    let timerObs1 = Observable<Int>.timer(3, scheduler: MainScheduler.instance)
    // 另一种是创建的 Observable 序列在经过设定的一段时间后，每隔一段时间产生一个元素。
    let timerObs2 = Observable<Int>.timer(3, period: 3, scheduler: MainScheduler.instance)



    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func just(_ sender: Any) {
        justObs.subscribe { event in
            print(event)
        }
    }
    
    @IBAction func of(_ sender: Any) {
        ofObs.subscribe { event in
            print(event)
        }
    }
    
    @IBAction func from(_ sender: Any) {
        fromObs.subscribe { (event) in
            print(event)
        }
    }
    
    @IBAction func empty(_ sender: Any) {
        emptyObs.subscribe { (event) in
            print(event)
        }
    }
    
    @IBAction func never(_ sender: Any) {
        neverObs.subscribe { (event) in
            print(event)
        }
    }
    
    @IBAction func error(_ sender: Any) {
        errorObs.subscribe { (event) in
            print(event)
        }
    }
    
    @IBAction func range(_ sender: Any) {
        rangeObs.subscribe { (event) in
            print(event)
        }
    }
    
    @IBAction func repeatElement(_ sender: Any) {
        repeatElementObs.subscribe { (event) in
            print(event)
        }
    }
    
    @IBAction func generate(_ sender: Any) {
        generateObs.subscribe { (event) in
            print(event)
        }
    }
    
    @IBAction func create(_ sender: Any) {
        createObs.subscribe { (event) in
            print(event)
        }
    }
    
    @IBAction func deferred(_ sender: Any) {
        //使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
        let factory : Observable<Int> = Observable.deferred {
            
            //让每次执行这个block时候都会让奇、偶数进行交替
            self.isOdd = !self.isOdd
            
            //根据isOdd参数，决定创建并返回的是奇数Observable、还是偶数Observable
            if self.isOdd {
                return Observable.of(1, 3, 5 ,7)
            }else {
                return Observable.of(2, 4, 6, 8)
            }
        }
        
        factory.subscribe { event in
            print("\(self.isOdd)", event)
        }
    }
    
    @IBAction func interval(_ sender: Any) {
        intervalObs.subscribe { (event) in
            print(event)
        }
    }
    
    @IBAction func timer(_ sender: Any) {
        timerObs1.subscribe { (event) in
            print(event)
        }
    }
    @IBAction func bind(_ sender: Any) {
        let disposeBag = DisposeBag()
        let bindObs = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        bindObs.subscribe(onNext: { (text) in
//            self.timeLabel.text = String(text)
//        }, onError: { (eror) in
//            print(eror)
//        }, onCompleted: {
//            print("completed")
//        }, onDisposed: {
//            print("dispose")
//        })
        bindObs
            .map { "当前索引数：\($0 )" }
            .bind { [weak self](text) in
                self?.timeLabel.text = String(text)
        }
        
    }
    
    @IBAction func any(_ sender: Any) {
        let disposeBag = DisposeBag()

        // AnyObserver 创建观察者配合 subscribe 方法使用
//        let observer:AnyObserver<Int> = AnyObserver { (event) in
//            switch event {
//            case .next(let data):
//                print("data=" + String(data))
//            case .error(let error):
//                print(error)
//            case .completed:
//                print("completed123")
//            }
//        }
//        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        observable.subscribe(observer)
        
        // AnyObserver 创建观察者配合 bindTo 方法使用
//        let observer:AnyObserver<String> = AnyObserver { [weak self](event) in
//            switch event {
//            case .next(let data):
//                print("data=" + String(data))
//                self?.timeLabel.text = data
//            case .error(let error):
//                print(error)
//            case .completed:
//                print("completed123")
//            }
//        }
//        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        observable
//            .map { "当前索引数：\($0 )" }
//            .bind(to:observer).disposed(by: disposeBag)
        
//        //Binder创建观察者 配合 bindTo 方法使用
//        let observer: Binder<String> = Binder(timeLabel) { (view, text) in
//            //收到发出的索引数后显示到label上
//            view.text = String(text)
//            print(text)
//        }
//        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        observable
//            .map { "AAAA\($0)" }
//            .bind(to: observer)
        
        //Binder创建观察者 配合 subscribe 方法使用
        let observer: Binder<Int> = Binder(timeLabel) { (view, text) in
            //收到发出的索引数后显示到label上
            view.text = "当前索引数：" + String(text)
            print(text)
        }
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable.subscribe(observer)
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
