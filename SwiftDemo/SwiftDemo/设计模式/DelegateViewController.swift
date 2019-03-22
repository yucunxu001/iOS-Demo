//
//  DelegateViewController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/20.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class DelegateViewController: UIViewController,CustomViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "代理"
        
        let custom = CustomView(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 300))
        custom.delegate = self;
        self.view.addSubview(custom)
        
    }
    
    func selectedItemButton(index: Int) {
        print("点击==\(index)")
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
