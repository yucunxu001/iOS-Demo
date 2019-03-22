//
//  KVOViewController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/20.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class KVOViewController: UIViewController {

    var person:Person!
    var ob: NSKeyValueObservation!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "KVO"
        
        person = Person(name: "yucunxu")
        person.addObserver(self, forKeyPath: "name", options: [.new,.old], context: nil)

        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 20, y: 100, width: kScreenWidth-40, height: 40)
        button.backgroundColor = UIColor.green
        button.setTitle("改变值", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func buttonClick() {
        person.name = "123456"
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let newValue = change?[.newKey] as! String
        let oldValue = change?[.oldKey] as! String
        if keyPath == "name" {
            print("newValue==\(newValue)")
            print("oldValue==\(oldValue)")
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
