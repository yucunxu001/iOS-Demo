//
//  GestureViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/26.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GestureViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.upGestureRecognizer()
        self.downGestureRecognizer()
        self.leftGestureRecognizer()
        self.rightGestureRecognizer()
        
        self.tapGesture()
    }
    
    func upGestureRecognizer() {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)
        
        swipe.rx.event.bind { [weak self] recognizer in
            //这个点是滑动的起点
            let point = recognizer.location(in: recognizer.view)
            print(point)
            
            let alert = UIAlertController(title: "弹框", message: "这是一个上滑手势,起点为：\(point)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    
    func downGestureRecognizer() {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
        
        swipe.rx.event.subscribe(onNext: { [weak self] recognizer in
            //这个点是滑动的起点
            let point = recognizer.location(in: recognizer.view)
            print(point)

            let alert = UIAlertController(title: "弹框", message: "这是一个下滑手势,起点为：\(point)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        })
        .disposed(by: disposeBag)

    }
    
    func leftGestureRecognizer() {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
        
        swipe.rx.event.subscribe(onNext: { [weak self] recognizer in
            //这个点是滑动的起点
            let point = recognizer.location(in: recognizer.view)
            print(point)
            
            let alert = UIAlertController(title: "弹框", message: "这是一个左滑手势,起点为：\(point)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        })
            .disposed(by: disposeBag)
        
    }
    
    func rightGestureRecognizer() {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
        
        swipe.rx.event.subscribe(onNext: { [weak self] recognizer in
            //这个点是滑动的起点
            let point = recognizer.location(in: recognizer.view)
            print(point)
            
            let alert = UIAlertController(title: "弹框", message: "这是一个右滑手势,起点为：\(point)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        })
            .disposed(by: disposeBag)
        
    }
    
    func tapGesture() {
        let tap = UITapGestureRecognizer()
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        
        tap.rx.event.subscribe(onNext: {[weak self] recognizer in
            let point = recognizer.location(in: recognizer.view)
            let alert = UIAlertController(title: "弹框", message: "这是一个点击手势,起点为：\(point)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }).disposed(by: disposeBag)
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
