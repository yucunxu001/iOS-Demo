//
//  CustomView.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/20.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

protocol CustomViewDelegate {
    func selectedItemButton(index:Int)
}

class CustomView: UIView {

    var delegate: CustomViewDelegate?
    let bgView:UIView
    
    override init(frame: CGRect) {
        bgView = UIView(frame: frame)
        super.init(frame: frame)
        self.setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        bgView.frame = self.bounds
        self.addSubview(bgView)
        
        let btn = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
        btn.backgroundColor = UIColor.green
        btn.tag = 101
        btn.setTitle("点击", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        bgView.addSubview(btn)
    }
    
    @objc func btnClick(sender:UIButton) {
        delegate?.selectedItemButton(index: sender.tag)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
