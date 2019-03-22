//
//  FactoryAnimal.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/21.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class FactoryAnimal: NSObject {

    var DogClassName:NSString = "狗"
    
    func createObject(className:NSString) -> Animal {
        if className == "Dog" {
            let dog = Dog()
            dog.dogCall()
            return dog
        }
        if className == "Cat" {
            let cat = Cat()
            cat.catchTheMouse()
            return cat
        }
        return Animal()
    }
}
