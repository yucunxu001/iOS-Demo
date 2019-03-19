



//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/12.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initPages()
    }
    
    func initPages() {
        self.navigationItem.title = "UIView基本用法";
        self.view.backgroundColor = UIColor.white
        
        let view = UIView(frame: CGRect(x: 20, y: kBarHeight+20, width: kScreenWidth-40, height: 300))
        view.backgroundColor = UIColor.green
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        self.view.addSubview(view)
        
        
        
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
