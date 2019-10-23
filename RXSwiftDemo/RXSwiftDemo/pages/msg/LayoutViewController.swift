//
//  LayoutViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/9/4.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class LayoutViewController: UIViewController {

    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var redViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func changeLayout(_ sender: Any) {
        view.layoutIfNeeded()

        if self.redViewHeight.constant == 100.0 {
            self.redViewHeight.constant = self.view.frame.height - 180
        }else {
            self.redViewHeight.constant = 100.0
        }
        UIView.animate(withDuration: 2.0) {
//            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
            
        }

    }

}
