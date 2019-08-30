//
//  KingfisherViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/30.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import Kingfisher

class KingfisherViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://img8.zol.com.cn/bbs/upload/17400/17399809.JPG")

//        self.imageView.kf.setImage(with: url)
//        self.imageView.kf.setImage(with: url,placeholder: UIImage(named: "lyf"))
        self.imageView.kf.setImage(with: url, options: [.transition(.fade(0.5))])

    }

}
