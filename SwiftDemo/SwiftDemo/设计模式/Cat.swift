//
//  Cat.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/21.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class Cat: Animal {

    func catchTheMouse() {
        print("抓老鼠")
    }
    
    override func printClassName() {
        print("\(NSStringFromClass(self.classForCoder))")
    }
}
