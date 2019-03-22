//
//  NotificationViewController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/20.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "通知"
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 20, y: 100, width: kScreenWidth-40, height: 40)
        button.backgroundColor = UIColor.green
        button.setTitle("发送通知", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        self.view.addSubview(button)
        
        //无参数通知
        NotificationCenter.default.addObserver(self, selector: #selector(change), name: NSNotification.Name("NOParam"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeParam), name: NSNotification.Name("HasParam"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeUserInfoParam), name: NSNotification.Name("HasParamUserInfo"), object: nil)

    }
    
    @objc func buttonClick() {
        NotificationCenter.default.post(name: NSNotification.Name("NOParam"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("HasParam"), object: "123456")
        let dict:Dictionary = ["name":"俞存旭","age":"27","sex":"男"]
        NotificationCenter.default.post(name: NSNotification.Name("HasParamUserInfo"), object: nil, userInfo: dict)
    }
    
    //MARk: 无参数通知
    @objc func change() {
        print("无参数通知")
    }
    //MARk: 使用object传参
    @objc func changeParam(notifi: Notification) {
        let str = notifi.object!
        print("str==\(str)")
    }
    
    @objc func changeUserInfoParam(notifi: Notification) {
        let name = notifi.userInfo!["name"]!
        let age = notifi.userInfo!["age"]!
        let sex = notifi.userInfo!["sex"]!
        print("name==\(name),age==\(age),sex==\(sex)")
        
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
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
