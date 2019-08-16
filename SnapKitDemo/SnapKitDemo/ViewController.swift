//
//  ViewController.swift
//  SnapKitDemo
//
//  Created by mkrq-yh on 2019/8/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let view1 = UIView()
    let view2 = UIView()
    var chageConstraint: Constraint? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let ScreenW = UIScreen.main.bounds.size.width
        let ScreenH = UIScreen.main.bounds.size.height
        view.backgroundColor = UIColor.white;

        view1.backgroundColor = .green
        view.addSubview(view1)
        
        view2.backgroundColor = .red
        view1.addSubview(view2)
        
        
        
        initPage() // equalTo view1边距20，view2边距50
//        initPage2() // edges 使用
//        initPage3() // 大等于或小等于
//        initPriority() // 优先级
//        initSize() // 尺寸 center
//        initConstraint()
//
//        let  btn = UIButton(frame: CGRect(x: 20, y: 300, width: 100, height: 40))
//        btn.backgroundColor = .gray
//        btn.addTarget(self, action: #selector(ViewController.btnClick), for: .touchUpInside)
//        view.addSubview(btn)
        
    }
    
    //MARK:view1边距20，view2边距50
    func initPage() {
        view1.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-20)
        }
        view2.snp.makeConstraints { (make) in
            make.top.equalTo(50)
            make.left.equalTo(50)
//            make.right.equalTo(-50)
//            make.bottom.equalTo(-50)
//            make.width.equalToSuperview().dividedBy(2)
//            make.height.equalToSuperview().dividedBy(2)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(0.3)

        }
    }
    
    // MARK: edges 使用
    func initPage2() {
        view1.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
        view2.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
        }
    }

    // MARK: 大等于或小等于
    func initPage3() {
        view1.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
        }
        view2.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.lessThanOrEqualTo(500)
            make.height.greaterThanOrEqualTo(100)
            make.top.equalToSuperview().offset(100)
            make.left.equalTo(view1)
        }
    }
    
    //MARK: 优先级
    func initPriority() {
        //优先级：.low，.medium，.high，.required
        view1.snp.makeConstraints { (make) in
            make.top.left.equalTo(50)
            make.height.equalTo(100)
            make.width.equalTo(100).priority(.high)
            make.width.equalTo(200).priority(.required)
        }
    }
    
    //MARK:尺寸 center
    func initSize() {
        view1.snp.makeConstraints { (make) in
            make.top.left.equalTo(30)
            make.size.equalTo(CGSize(width: 300, height: 200))
        }
        view2.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.center.equalToSuperview()
        }
    }
    
    func initConstraint() {
        view1.snp.makeConstraints { (make) in
            make.top.equalTo(50)
            self.chageConstraint = make.left.equalToSuperview().offset(20).constraint
            make.width.height.equalTo(100)
        }
    }
    
    @objc func btnClick() {
        print("btnClick")
        // 更新某一个约束
//        self.chageConstraint?.update(offset: 100)
//        self.setNeedsLayout()
        
        //更新约束
//        view1.snp.updateConstraints { (make) in
//            make.left.equalTo(100)
//        }
        //删除旧约束添加新约束
        view1.snp.remakeConstraints { (make) in
            make.left.right.equalTo(view)
//            make.top.equalTo(self.topLayoutGuide.snp.bottom)
//            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

