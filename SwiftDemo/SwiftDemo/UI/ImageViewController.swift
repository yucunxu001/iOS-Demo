//
//  ImageViewController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/12.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initPages()
    }
    
    func initPages() {
        self.navigationItem.title = "UIImageView基本用法";
        self.view.backgroundColor = UIColor.white
        
        let imageView = UIImageView(frame: CGRect(x: 20, y: kBarHeight+30, width: 100, height: 100))
//        imageView.image = UIImage(named: "item")
        let url = URL(string: "http://pic9.nipic.com/20100824/2531170_082435310724_2.jpg")
        let data = try!Data(contentsOf: url!)
        let img = UIImage(data: data)
        imageView.image = img
        self.view.addSubview(imageView)
        
        
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
