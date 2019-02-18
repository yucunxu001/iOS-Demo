//
//  ViewController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/1/28.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let list = [5,7,8,3,2,1,10]
        for index in list {
            if index > 5 {
                print("index==\(index)")
            }
        }

        var z = add(x: 2, y: 3)
        print("z=\(z)");
        z = 10
        print("z=\(z)");

    }
    
    func add(x:NSInteger,y:NSInteger) -> NSInteger {
        
        var z = 20
        func demo() -> NSInteger {
            return x+y;
        }
        z = demo()
        
        return z
    }
    
    


}

