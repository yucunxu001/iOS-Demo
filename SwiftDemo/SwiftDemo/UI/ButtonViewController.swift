//
//  ButtonViewController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/12.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class ButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initPages()
    }
    
    func initPages() {
        self.navigationItem.title = "UIButton基本用法";
        self.view.backgroundColor = UIColor.white

        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 20, y: kBarHeight+20, width: kScreenWidth-40, height: 50)
        button.setTitle("普通按钮", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.setTitleColor(UIColor.blue, for: .selected)
        button.backgroundColor = UIColor.green
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tag = 100;
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = button.frame.size.height/2
        button.layer.masksToBounds = true
//        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func buttonClick(sender:UIButton) {
        print("tag==\(sender.tag)")
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setTitle("选中", for: .normal)
        } else {
            sender.setTitle("未选中", for: .normal)
        }
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
