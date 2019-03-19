//
//  ScrollViewController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/12.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initPages()
    }
    
    func initPages() {
        self.navigationItem.title = "UIScrollView基本用法";
        self.view.backgroundColor = UIColor.white
        
        let scroll = UIScrollView(frame: CGRect(x: 20, y: kBarHeight+20, width: kScreenWidth-40, height: kScreenHeight-kBarHeight-40))
        scroll.backgroundColor = UIColor.white
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        self.view.addSubview(scroll)
        
        let arr = [
            "111111111111111",
            "222222222222222",
            "333333333333333",
            "444444444444444",
            "555555555555555",
            "666666666666666",
            "777777777777777",
            "888888888888888",
            "999999999999999"
        ]
        var height:CGFloat = 20
        for (index,value) in arr.enumerated() {
            print("index==\(index),value==\(value)")
            let label = UILabel(frame: CGRect(x: 20, y: height, width: scroll.frame.size.width-40, height: 50))
            label.text = value;
            label.textColor = UIColor.red;
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 18)
            label.layer.borderWidth = 2
            label.layer.borderColor = UIColor.red.cgColor
            scroll.addSubview(label)
            height = label.frame.origin.y+label.frame.size.height+50
        }
        scroll.contentSize = CGSize(width: scroll.frame.size.width, height: height+20)
        
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
