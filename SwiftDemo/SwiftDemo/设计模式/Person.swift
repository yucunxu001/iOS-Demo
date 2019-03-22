//
//  Person.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/20.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

@objcMembers class Person: NSObject {
    dynamic var name:String  = ""
    init(name:String) {
        self.name = name
    }
}
