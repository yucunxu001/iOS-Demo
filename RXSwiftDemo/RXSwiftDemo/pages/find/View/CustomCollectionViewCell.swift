//
//  CustomCollectionViewCell.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/28.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    var lable:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
        
        self.lable = UILabel(frame: frame)
        self.lable.textColor = UIColor.red
        self.lable.textAlignment = .center
        self.contentView.addSubview(self.lable)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lable.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
