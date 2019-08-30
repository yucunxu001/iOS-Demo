//
//  HeaderView.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/29.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {

    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.red
        label = UILabel(frame: frame)
        label.textColor = UIColor.green
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
