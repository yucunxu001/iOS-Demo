//
//  Dog.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/21.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class Dog: Animal {

    func dogCall() {
        print("汪汪汪！")
    }
    
    override func printClassName() {
        print("\(NSStringFromClass(self.classForCoder))")
    }
}
