//
//  OperatorViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/22.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OperatorViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buffer(_ sender: Any) {
        print("buffer")
        /*
         buffer 方法作用是缓冲组合，第一个参数是缓冲时间，第二个参数是缓冲个数，第三个参数是线程。
         该方法简单来说就是缓存 Observable 中发出的新元素，当元素达到某个数量，或者经过了特定的时间，它就会将这个元素集合发送出来。
         */
        let subject = PublishSubject<String>()
        subject
            .buffer(timeSpan: 3, count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        subject.onNext("4")
        subject.onNext("5")
        subject.onNext("6")
        subject.onNext("7")
        subject.onNext("8")
        subject.onNext("9")
        subject.onNext("0")

    }
    @IBAction func window(_ sender: Any) {
        /*
         window 操作符和 buffer 十分相似。不过 buffer 是周期性的将缓存的元素集合发送出来，而 window 周期性的将元素集合以 Observable 的形态发送出来。
         同时 buffer要等到元素搜集完毕后，才会发出元素序列。而 window 可以实时发出元素序列。
         */
        let subject = PublishSubject<String>()
        subject
            .window(timeSpan: 3, count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] in
                print("subject \($0)")
                $0.asObservable()
                    .subscribe(onNext: { print("dddd \($0)") })
                    .disposed(by: self!.disposeBag)
            })
            .disposed(by: disposeBag)
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        subject.onNext("4")
        subject.onNext("5")

    }
    
    
    @IBAction func map(_ sender: Any) {
        print("map")
        /*该操作符通过传入一个函数闭包把原来的 Observable 序列转变为一个新的 Observable 序列。*/
        let subject = PublishSubject<Int>()
        subject
            .map { $0*10 }
            .subscribe(onNext:  { print($0) })
            .disposed(by: disposeBag)
        subject.onNext(1)
        subject.onNext(2)
        subject.onNext(3)

    }
    
    @IBAction func flatMap(_ sender: Any) {
        print("flatMap")
        /*
         map 在做转换的时候容易出现“升维”的情况。即转变之后，从一个序列变成了一个序列的序列。
         而 flatMap 操作符会对源 Observable 的每一个元素应用一个转换方法，将他们转换成 Observables。 然后将这些 Observables 的元素合并之后再发送出来。即又将其 "拍扁"（降维）成一个 Observable 序列。
         这个操作符是非常有用的。比如当 Observable 的元素本生拥有其他的 Observable 时，我们可以将所有子 Observables 的元素发送出来。
         */
        let first = BehaviorSubject(value: 1)
        let second = BehaviorSubject(value: 2)
        let third = Variable(first)
        third.asObservable()
            .flatMap { $0 }
            .subscribe(onNext: { (x) in
                print("onNext=\(x)")
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("onCompleted")
            }) {
                print("dis")
        }
        first.onNext(3)
        third.value = second
    }
    @IBAction func flatMapLatest(_ sender: Any) {
        /*flatMapLatest与flatMap 的唯一区别是：flatMapLatest只会接收最新的value 事件。*/
        let first = BehaviorSubject(value: 1)
        let second = BehaviorSubject(value: 2)
        let third = Variable(first)
        third.asObservable()
            .flatMapLatest { $0 }
            .subscribe(onNext:{ print("onNext=\($0)") })
            .disposed(by: disposeBag)
        first.onNext(3)
        third.value = second
        second.onNext(4)
        first.onNext(5)

    }
    @IBAction func contatMap(_ sender: Any) {
        /*
         concatMap 与 flatMap 的唯一区别是：当前一个 Observable 元素发送完毕后，后一个Observable 才可以开始发出元素。或者说等待前一个 Observable 产生完成事件后，才对后一个 Observable 进行订阅
         */
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        let variable = Variable(subject1)
        variable.asObservable()
            .concatMap { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        variable.value = subject2
        subject2.onNext("2")
        subject1.onNext("C")
        subject1.onCompleted() //只有前一个序列结束后，才能接收下一个序列
    }
    
    @IBAction func scan(_ sender: Any) {
        print("scan")
        /*scan 就是先给一个初始化的数，然后不断的拿前一个结果和最新的值进行处理操作。*/
        Observable
            .of(1,2,3,4,5)
            .scan(0) { acum, elem in
                acum + elem
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    @IBAction func groupBy(_ sender: Any) {
        /*
         groupBy 操作符将源 Observable 分解为多个子 Observable，然后将这些子 Observable 发送出来。
         也就是说该操作符会将元素通过某个键进行分组，然后将分组后的元素序列以 Observable 的形态发送出来。
         */
        Observable.of(0,1,2,3,4,5,6)
            .groupBy(keySelector: {(element) in
                return element % 2 == 0 ? "偶数" : "基数"
            })
            .subscribe({ (event) in
                switch event {
                case .next(let group):
                    group.asObservable()
                        .subscribe({ (event) in
                            print("key：\(group.key)---event：\(event)")
                        })
                        .disposed(by: self.disposeBag)
                default:
                    print("default")
                }
            })
        .disposed(by: disposeBag)
    }
    
    @IBAction func filter(_ sender: Any) {
        /*该操作符就是用来过滤掉某些不符合要求的事件。*/
        Observable.of(0,12,3,4,55,6,77,88,9)
            .filter { (x) -> Bool in
                return x > 10
            }
            .subscribe(onNext: { print("\($0)") })
            .disposed(by: disposeBag)
    }
    
    @IBAction func untilChanged(_ sender: Any) {
        /*该操作符用于过滤掉连续重复的事件。*/
        Observable
            .of(1,1,1,2,2,2,4,1,2,5,6,6,6)
            .distinctUntilChanged()
            .subscribe(onNext: { print("\($0)") })
            .disposed(by: disposeBag)
    }
    
    @IBAction func single(_ sender: Any) {
        /*
         限制只发送一次事件，或者满足条件的第一个事件。
         如果存在有多个事件或者没有事件都会发出一个 error 事件。
         如果只有一个事件，则不会发出 error事件。
         */
        Observable
            .of(1,2,3,4,5,6)
            .single { (x) -> Bool in
                return x%2 == 0
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        Observable
            .of(1,2,3,4,5,6)
            .single()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    @IBAction func elementAt(_ sender: Any) {
        /*该方法实现只处理在指定位置的事件。*/
        Observable
            .of(1,2,3,4,5,6)
            .elementAt(3)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    @IBAction func ignore(_ sender: Any) {
        /*
         该操作符可以忽略掉所有的元素，只发出 error或completed 事件。
         如果我们并不关心 Observable 的任何元素，只想知道 Observable 在什么时候终止，那就可以使用 ignoreElements 操作符。
         */
        Observable.of(1,2,3,4)
            .ignoreElements()
            .subscribe(onCompleted: {
                
            }) { (err) in
                print(err)
            }
            .disposed(by: disposeBag)
    }
    
    @IBAction func take(_ sender: Any) {
        /*
         该方法实现仅发送 Observable 序列中的前 n 个事件，在满足数量之后会自动 .completed。
         */
        Observable.of(1,2,3,4,5,6)
            .take(2)
            .subscribe(onNext: { print($0)})
            .disposed(by: disposeBag)
    }
    
    @IBAction func takeLast(_ sender: Any) {
        /*该方法实现仅发送 Observable序列中的后 n 个事件。*/
        Observable.of(1,2,3,4,5,6)
            .takeLast(2)
            .subscribe(onNext: { print($0)})
            .disposed(by: disposeBag)
    }
    
    @IBAction func skip(_ sender: Any) {
        /*该方法用于跳过源 Observable 序列发出的前 n 个事件。*/
        Observable.of(1,2,3,4,5,6)
            .skip(2)
            .subscribe(onNext: { print($0)})
            .disposed(by: disposeBag)
    }
    
    @IBAction func simple(_ sender: Any) {
        /*
         Sample 除了订阅源Observable 外，还可以监视另外一个 Observable， 即 notifier 。
         每当收到 notifier 事件，就会从源序列取一个最新的事件并发送。而如果两次 notifier 事件之间没有源序列的事件，则不发送值。
         */
        let source = PublishSubject<Int>()
        let notifier = PublishSubject<String>()
        
        source
            .sample(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        source.onNext(1)
        
        //让源序列接收接收消息
        notifier.onNext("A")

        source.onNext(2)
        
        //让源序列接收接收消息
        notifier.onNext("B")
        notifier.onNext("C")

        source.onNext(3)
        source.onNext(4)

        //让源序列接收接收消息
        notifier.onNext("D")

        source.onNext(5)

        //让源序列接收接收消息
        notifier.onCompleted()
    }
    
    @IBAction func debounce(_ sender: Any) {
        /*
         debounce
         操作符可以用来过滤掉高频产生的元素，它只会发出这种元素：该元素产生后，一段时间内没有新元素产生
         换句话说就是，队列中的元素如果和下一个元素的间隔小于了指定的时间间隔，那么这个元素将被过滤掉。
         debounce 常用在用户输入的时候，不需要每个字母敲进去都发送一个事件，而是稍等一下取最后一个事件。
         */
        
//        let publish = PublishSubject<Int>()
//        publish
//            .debounce(1, scheduler: MainScheduler.instance)
//            .subscribe(onNext: { int in
//                print("element:", int)
//            })
//            .disposed(by: disposeBag)
//        publish.onNext(1)
//        publish.onNext(2)
//        publish.onNext(3)
//        publish.onNext(4)
//        publish.onNext(5)
    }
    
    @IBAction func amb(_ sender: Any) {
        /*当传入多个 Observables 到 amb 操作符时，它将取第一个发出元素或产生事件的 Observable，然后只发出它的元素。并忽略掉其他的 Observables。*/
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        let subject3 = PublishSubject<Int>()
        
        subject1
            .amb(subject2)
            .amb(subject3)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject2.onNext(1)
        subject1.onNext(20)
        subject2.onNext(2)
        subject1.onNext(40)
        subject3.onNext(0)
        subject2.onNext(3)
        subject1.onNext(60)
        subject3.onNext(0)
        subject3.onNext(0)
    }
    @IBAction func takeWhile(_ sender: Any) {
        /*该方法依次判断 Observable 序列的每一个值是否满足给定的条件。 当第一个不满足条件的值出现时，它便自动完成。*/
        Observable.of(2, 3, 4, 5, 6)
            .takeWhile { $0 < 4 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    @IBAction func takeUntil(_ sender: Any) {
        /*
         除了订阅源 Observable 外，通过 takeUntil 方法我们还可以监视另外一个 Observable， 即 notifier。
         如果 notifier 发出值或 complete 通知，那么源 Observable 便自动完成，停止发送事件。
         */
        let source = PublishSubject<String>()
        let notifier = PublishSubject<String>()
        
        source
            .takeUntil(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        source.onNext("a")
        source.onNext("b")
        source.onNext("c")
        source.onNext("d")
        
        //停止接收消息
        notifier.onNext("z")
        
        source.onNext("e")
        source.onNext("f")
        source.onNext("g")
    }
    
    @IBAction func skipWhile(_ sender: Any) {
        /*
         该方法用于跳过前面所有满足条件的事件。
         一旦遇到不满足条件的事件，之后就不会再跳过了。
         */
        Observable
            .of(7,2, 3, 4, 5, 6)
            .skipWhile { $0 < 4 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    @IBAction func skipUntil(_ sender: Any) {
        /*
         同上面的 takeUntil 一样，skipUntil 除了订阅源 Observable 外，通过 skipUntil方法我们还可以监视另外一个 Observable， 即 notifier 。
         与 takeUntil 相反的是。源 Observable 序列事件默认会一直跳过，直到 notifier 发出值或 complete 通知。
         */
        
        let source = PublishSubject<Int>()
        let notifier = PublishSubject<Int>()
        source
            .skipUntil(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        source.onNext(1)
        source.onNext(2)
        source.onNext(3)
        source.onNext(4)
        source.onNext(5)
        
        //开始接收消息
        notifier.onNext(0)
        source.onNext(6)
        source.onNext(7)
        source.onNext(8)
        
        //仍然接收消息
        notifier.onNext(0)
        source.onNext(9)
    }
    
    @IBAction func startWith(_ sender: Any) {
        /*该方法会在 Observable 序列开始之前插入一些事件元素。即发出事件消息之前，会先发出这些预先插入的事件消息*/
        Observable.of("2", "3")
            .startWith("1")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    @IBAction func merge(_ sender: Any) {
        /*该方法可以将多个（两个或两个以上的）Observable 序列合并成一个 Observable序列。*/
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        
        Observable.of(subject1, subject2)
            .merge()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext(20)
        subject1.onNext(40)
        subject1.onNext(60)
        subject2.onNext(1)
        subject1.onNext(80)
        subject1.onNext(100)
        subject2.onNext(1)
    }
    
    @IBAction func zip(_ sender: Any) {
        /*
         该方法可以将多个（两个或两个以上的）Observable 序列压缩成一个 Observable 序列。
         而且它会等到每个 Observable 事件一一对应地凑齐之后再合并。
         */
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<String>()
        
        Observable.zip(subject1, subject2) {
            "\($0)\($1)"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext(1)
        subject2.onNext("A")
        subject1.onNext(2)
        subject2.onNext("B")
        subject2.onNext("C")
        subject2.onNext("D")
        subject1.onNext(3)
        subject1.onNext(4)
        subject1.onNext(5)
    }
    @IBAction func combine(_ sender: Any) {
        /*该方法同样是将多个（两个或两个以上的）Observable 序列元素进行合并。
        但与 zip 不同的是，每当任意一个 Observable 有新的事件发出时，它会将每个 Observable 序列的最新的一个事件元素进行合并。*/
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<String>()
        
        Observable.combineLatest(subject1, subject2) {
            "\($0)\($1)"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext(1)
        subject2.onNext("A")
        subject1.onNext(2)
        subject2.onNext("B")
        subject2.onNext("C")
        subject2.onNext("D")
        subject1.onNext(3)
        subject1.onNext(4)
        subject1.onNext(5)
    }
    @IBAction func withLatestFrom(_ sender: Any) {
        /*该方法将两个 Observable 序列合并为一个。
         每当 self 队列发射一个元素时，便从第二个序列中取出最新的一个值。*/
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        
        subject1.withLatestFrom(subject2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("A")
        subject2.onNext("1")
        subject1.onNext("B")
        subject1.onNext("C")
        subject2.onNext("2")
        subject1.onNext("D")
    }
    @IBAction func switchLatest(_ sender: Any) {
        /*
         switchLatest 有点像其他语言的switch 方法，可以对事件流进行转换。
         比如本来监听的 subject1，我可以通过更改 variable 里面的 value 更换事件源。变成监听 subject2。
         */
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let variable = Variable(subject1)
        
        variable.asObservable()
            .switchLatest()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        subject1.onNext("C")
        
        //改变事件源
        variable.value = subject2
        subject1.onNext("D")
        subject2.onNext("2")
        
        //改变事件源
        variable.value = subject1
        subject2.onNext("3")
        subject1.onNext("E")
    }
    
    @IBAction func toArray(_ sender: Any) {
        /*该操作符先把一个序列转成一个数组，并作为一个单一的事件发送，然后结束。*/
        Observable.of(1, 2, 3)
            .toArray()
            .subscribe({ print($0) })
            .disposed(by: disposeBag)
    }
    @IBAction func reduce(_ sender: Any) {
        /*
         reduce 接受一个初始值，和一个操作符号。
         reduce 将给定的初始值，与序列里的每个值进行累计运算。得到一个最终结果，并将其作为单个值发送出去
         */
        
        Observable.of(1,2,3,4,5)
            .reduce(0, accumulator: +)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    @IBAction func concat(_ sender: Any) {
        /*
         concat 会把多个 Observable 序列合并（串联）为一个 Observable 序列。
         并且只有当前面一个 Observable 序列发出了 completed 事件，才会开始发送下一个  Observable 序列事件。
         */
        let subject1 = BehaviorSubject(value: 1)
        let subject2 = BehaviorSubject(value: 2)
        let variable = Variable(subject1)
        variable.asObservable()
            .concat()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject2.onNext(2)
        subject1.onNext(1)
        subject1.onNext(1)
        subject1.onCompleted()

        variable.value = subject2
        subject2.onNext(2)
    }
    
    @IBAction func connect(_ sender: Any) {
        /*
         可连接的序列（Connectable Observable）：
         （1）可连接的序列和一般序列不同在于：有订阅时不会立刻开始发送事件消息，只有当调用 connect()之后才会开始发送值。
     （2）可连接的序列可以让所有的订阅者订阅后，才开始发出事件消息，从而保证我们想要的所有订阅者都能接收到事件消息。
         */
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
    }
    
    @IBAction func publish(_ sender: Any) {
        /*publish
         方法会将一个正常的序列转换成一个可连接的序列。同时该序列不会立刻发送事件，只有在调用 connect 之后才会开始。*/
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .publish()
        //第一个订阅者（立刻开始订阅）
        _ = interval.subscribe(onNext: { print("订阅1: \($0)") })
        //相当于把事件消息推迟了两秒
        delay(2) {
            _ = interval.connect()
        }
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval.subscribe(onNext: { print("订阅2: \($0)") })
        }
    }
    
    ///延迟执行
    /// - Parameters:
    ///   - delay: 延迟时间（秒）
    ///   - closure: 延迟执行的闭包
    public func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    @IBAction func replay(_ sender: Any) {
        /*
         replay 同上面的 publish 方法相同之处在于：会将将一个正常的序列转换成一个可连接的序列。同时该序列不会立刻发送事件，只有在调用 connect 之后才会开始。
         replay 与 publish 不同在于：新的订阅者还能接收到订阅之前的事件消息（数量由设置的 bufferSize 决定）。
         */
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .replay(5)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //相当于把事件消息推迟了两秒
        delay(2) {
            _ = interval.connect()
        }
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
    }
    
    @IBAction func multicast(_ sender: Any) {
        /*
         multicast 方法同样是将一个正常的序列转换成一个可连接的序列。
         同时 multicast 方法还可以传入一个 Subject，每当序列发送事件时都会触发这个 Subject 的发送。
         */
        //创建一个Subject（后面的multicast()方法中传入）
        let subject = PublishSubject<Int>()
        //这个Subject的订阅
        _ = subject.subscribe(onNext: { print("Subject: \($0)") })
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .multicast(subject)
        //第一个订阅者（立刻开始订阅）
        _ = interval.subscribe(onNext: { print("订阅1: \($0)") })
        //相当于把事件消息推迟了两秒
        delay(2) {
            _ = interval.connect()
        }
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
    }
    
    @IBAction func refcount(_ sender: Any) {
        /*
         refCount 操作符可以将可被连接的 Observable 转换为普通 Observable
         即该操作符可以自动连接和断开可连接的 Observable。当第一个观察者对可连接的Observable 订阅时，那么底层的 Observable 将被自动连接。当最后一个观察者离开时，那么底层的 Observable 将被自动断开连接。
         */
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .publish()
            .refCount()
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
    }
    @IBAction func share(_ sender: Any) {
        /*
         该操作符将使得观察者共享源 Observable，并且缓存最新的 n 个元素，将这些元素直接发送给新的观察者。
         简单来说 shareReplay 就是 replay 和 refCount 的组合。
         */
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .share(replay: 5)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
    }
    @IBAction func delay(_ sender: Any) {
        /*该操作符会将 Observable 的所有元素都先拖延一段设定好的时间，然后才将它们发送出来*/
        Observable.of(1,2,3)
            .delay(3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    @IBAction func delaySubscription(_ sender: Any) {
        /*使用该操作符可以进行延时订阅。即经过所设定的时间后，才对 Observable 进行订阅操作。*/
        Observable.of(1,2,3)
            .delaySubscription(3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    @IBAction func materialize(_ sender: Any) {
        /*
         该操作符可以将序列产生的事件，转换成元素。
         通常一个有限的 Observable 将产生零个或者多个 onNext 事件，最后产生一个 onCompleted 或者onError事件。而 materialize 操作符会将 Observable 产生的这些事件全部转换成元素，然后发送出来
         */
        Observable.of(1, 2, 1)
            .materialize()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    @IBAction func dematerialize(_ sender: Any) {
        /*该操作符的作用和 materialize 正好相反，它可以将 materialize 转换后的元素还原。*/
        Observable.of(1, 2, 1)
            .materialize()
            .dematerialize()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    @IBAction func timeout(_ sender: Any) {
        /*使用该操作符可以设置一个超时时间。如果源 Observable 在规定时间内没有发任何出元素，就产生一个超时的 error 事件。
         */
        //定义好每个事件里的值以及发送的时间
        let times = [
            [ "value": 1, "time": 0 ],
            [ "value": 2, "time": 0.5 ],
            [ "value": 3, "time": 1.5 ],
            [ "value": 4, "time": 4 ],
            [ "value": 5, "time": 5 ]
        ]
        
        //生成对应的 Observable 序列并订阅
        Observable.from(times)
            .flatMap { item in
                return Observable.of(Int(item["value"]!))
                    .delaySubscription(Double(item["time"]!),
                                       scheduler: MainScheduler.instance)
            }
            .timeout(2, scheduler: MainScheduler.instance) //超过两秒没发出元素，则产生error事件
            .subscribe(onNext: { element in
                print(element)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func using(_ sender: Any) {
        /*使用 using 操作符创建 Observable 时，同时会创建一个可被清除的资源，一旦 Observable终止了，那么这个资源就会被清除掉了。*/
        //一个无限序列（每隔0.1秒创建一个序列数 ）
        let infiniteInterval$ = Observable<Int>
            .interval(0.1, scheduler: MainScheduler.instance)
            .do(
                onNext: { print("infinite$: \($0)") },
                onSubscribe: { print("开始订阅 infinite$")},
                onDispose: { print("销毁 infinite$")}
        )
        
        //一个有限序列（每隔0.5秒创建一个序列数，共创建三个 ）
        let limited$ = Observable<Int>
            .interval(0.5, scheduler: MainScheduler.instance)
            .take(2)
            .do(
                onNext: { print("limited$: \($0)") },
                onSubscribe: { print("开始订阅 limited$")},
                onDispose: { print("销毁 limited$")}
        )
        
        //使用using操作符创建序列
        let o: Observable<Int> = Observable.using({ () -> AnyDisposable in
            return AnyDisposable(infiniteInterval$.subscribe())
        }, observableFactory: { _ in return limited$ }
        )
        o.subscribe()
    }

}

class AnyDisposable: Disposable {
    let _dispose: () -> Void
    
    init(_ disposable: Disposable) {
        _dispose = disposable.dispose
    }
    
    func dispose() {
        _dispose()
    }
}
