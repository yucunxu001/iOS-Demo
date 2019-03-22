
//
//  DesignModeViewController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/20.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class DesignModeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "设计模式"
        
        let kvoBtn = UIButton(type: .custom)
        kvoBtn.frame = CGRect(x: 20, y: 100, width: kScreenWidth-40, height: 40)
        kvoBtn.backgroundColor = UIColor.green
        kvoBtn.setTitle("KVO设计模式", for: .normal)
        kvoBtn.setTitleColor(UIColor.red, for: .normal)
        kvoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        kvoBtn.addTarget(self, action: #selector(kvoBtnClick(sender:)), for: .touchUpInside)
        self.view.addSubview(kvoBtn)
        
        let nitifiBtn = UIButton(type: .custom)
        nitifiBtn.frame = CGRect(x: 20, y: kvoBtn.frame.origin.y+kvoBtn.frame.size.height+20, width: kScreenWidth-40, height: 40)
        nitifiBtn.backgroundColor = UIColor.green
        nitifiBtn.setTitle("通知", for: .normal)
        nitifiBtn.setTitleColor(UIColor.red, for: .normal)
        nitifiBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        nitifiBtn.addTarget(self, action: #selector(nitifiBtnClick(sender:)), for: .touchUpInside)
        self.view.addSubview(nitifiBtn)
        
        let delegateBtn = UIButton(type: .custom)
        delegateBtn.frame = CGRect(x: 20, y: nitifiBtn.frame.origin.y+nitifiBtn.frame.size.height+20, width: kScreenWidth-40, height: 40)
        delegateBtn.backgroundColor = UIColor.green
        delegateBtn.setTitle("代理", for: .normal)
        delegateBtn.setTitleColor(UIColor.red, for: .normal)
        delegateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        delegateBtn.addTarget(self, action: #selector(delegateBtnClick(sender:)), for: .touchUpInside)
        self.view.addSubview(delegateBtn)
        
        let factoryBtn = UIButton(type: .custom)
        factoryBtn.frame = CGRect(x: 20, y: delegateBtn.frame.origin.y+delegateBtn.frame.size.height+20, width: kScreenWidth-40, height: 40)
        factoryBtn.backgroundColor = UIColor.green
        factoryBtn.setTitle("工厂", for: .normal)
        factoryBtn.setTitleColor(UIColor.red, for: .normal)
        factoryBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        factoryBtn.addTarget(self, action: #selector(factoryBtnClick(sender:)), for: .touchUpInside)
        self.view.addSubview(factoryBtn)
    }
    
    @objc func kvoBtnClick(sender:UIButton) {
        let kvo = KVOViewController()
        self.navigationController?.pushViewController(kvo, animated: true)
        
    }
    
    @objc func nitifiBtnClick(sender:UIButton) {
        let notifi = NotificationViewController()
        self.navigationController?.pushViewController(notifi, animated: true)
    }
    
    @objc func delegateBtnClick(sender:UIButton) {
        let del = DelegateViewController()
        self.navigationController?.pushViewController(del, animated: true)
    }

    @objc func factoryBtnClick(sender:UIButton) {
        let fac = FactoryViewController()
        self.navigationController?.pushViewController(fac, animated: true)
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
