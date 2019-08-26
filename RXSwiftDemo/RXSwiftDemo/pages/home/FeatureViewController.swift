//
//  FeatureViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/23.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//与数据相关的错误类型
enum DataError: Error {
    case cantParseJSON
}

class FeatureViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    func getRepo(_ repo: String) -> Single<[String: Any]> {
//        return Single<[String: Any]>.create { single in
//            let url = URL(string: "https://api.github.com/repos/\(repo)")!
//            let task = URLSession.shared.dataTask(with: url) {
//                data, _, error in
//
//                if let error = error {
//                    single(.error(error))
//                    return
//                }
//
//                guard let data = data,
//                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
//                    let result = json as? [String: Any] else {
//                        single(.error(DataError.cantParseJSON))
//                        return
//                }
//
//                single(.success(result))
//            }
//
//            task.resume()
//
//            return Disposables.create { task.cancel() }
//        }
//    }
    
    
    @IBAction func Single(_ sender: Any) {
        print("Single")
                
    }
    
//    //将数据缓存到本地
//    func cacheLocally() -> Completable {
//        Completable()
//        return Completable.create { completable in
//            //将数据缓存到本地（这里掠过具体的业务代码，随机成功或失败）
//            let success = (arc4random() % 2 == 0)
//
//            guard success else {
//                completable(.error(CacheError.failedCaching))
//                return Disposables.create {}
//            }
//
//            completable(.completed)
//            return Disposables.create {}
//        }
//    }
//
//    //与缓存相关的错误类型
//    enum CacheError: Error {
//        case failedCaching
//    }
    
    @IBAction func Completable(_ sender: Any) {
        
//        cacheLocally()
//            .subscribe { completable in
//                switch completable {
//                case .completed:
//                    print("保存成功!")
//                case .error(let error):
//                    print("保存失败: \(error.localizedDescription)")
//                }
//            }
//            .disposed(by: disposeBag)
    }
    
    
    func generateString() -> Maybe<String> {
        return Maybe<String>.create { maybe in
            //成功并发出一个元素
            maybe(.success("hangge.com"))
            //成功但不发出任何元素
            maybe(.completed)
            //失败
            //maybe(.error(StringError.failedGenerate))
            return Disposables.create {}
        }
    }
    
    //与缓存相关的错误类型
    enum StringError: Error {
        case failedGenerate
    }
    
    @IBAction func MayBe(_ sender: Any) {
        generateString()
            .subscribe { maybe in
                switch maybe {
                case .success(let element):
                    print("执行完毕，并获得元素：\(element)")
                case .completed:
                    print("执行完毕，且没有任何元素。")
                case .error(let error):
                    print("执行失败: \(error.localizedDescription)")
                }
            }
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
