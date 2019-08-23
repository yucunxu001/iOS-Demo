//
//  ErrorViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/23.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum MyError:Error {
    case A
    case B
}

class ErrorViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func catchErrorJustReturn(_ sender: Any) {
        /*当遇到 error 事件的时候，就返回指定的值，然后结束。*/
        let subject = PublishSubject<String>()
        subject
            .catchErrorJustReturn("错误")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        subject.onError(MyError.A)
        subject.onNext("4")
        subject.onNext("5")
        subject.onNext("6")

    }
    
    @IBAction func catchError(_ sender: Any) {
        /*
         该方法可以捕获 error，并对其进行处理。
         同时还能返回另一个 Observable 序列进行订阅（切换到新的序列）
         */
        let subject = PublishSubject<String>()
        let subject2 = Observable.of("1","2","3")
        subject
            .catchError {
                print("Error:", $0)
                return subject2
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        subject.onNext("AAA")
        subject.onError(MyError.A)
        subject.onNext("BBB")
    }
    
    @IBAction func retry(_ sender: Any) {
        var count = 1
        let subject = Observable<Int>.create { observer in
            observer.onNext(1)
            observer.onNext(2)
            if count == 1 {
                observer.onError(MyError.A)
                print("Error encountered")
                count += 1
            }
            observer.onNext(3)
            observer.onNext(4)
            return Disposables.create()
        }
        
        subject
            .retry(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    @IBAction func debug(_ sender: Any) {
        /*
         我们可以将 debug 调试操作符添加到一个链式步骤当中，这样系统就能将所有的订阅者、事件、和处理等详细信息打印出来，方便我们开发调试
         */
        Observable.of(3,4,5,6)
            .startWith(1)
            .startWith(2)
            .debug("调试")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    @IBAction func total(_ sender: Any) {
        print("Resource tracing1: \(RxSwift.Resources.total)")

        Observable.of("BBB", "CCC")
            .startWith("AAA")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        //必须要在真机测试
        print("Resource tracing2: \(RxSwift.Resources.total)")

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
