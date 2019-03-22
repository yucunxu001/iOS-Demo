//
//  BaseDataTypeController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/15.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

enum SomeType {
    case SomeTypeOne
    case SomeTypeTwo
    case SomeTypeThree
}

struct MyStructTest {
    var originX = 100
    var originY = 100
    var width = 200
    var height = 300
}

class BaseDataTypeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initPages()
    }
    
    func initPages() {
        self.navigationItem.title = "基本数据类型";
        self.view.backgroundColor = UIColor.white
        
        let v1:Int = 100;
        let v2:Double = 100.222
        let v3:Float = 100.123
        let v4:String = "100"
        let v5:Array = ["1","2","3","4"]
        let v6:Dictionary = ["name":"yucunxu","age":"27","height":"79"]
        let v7 = (name:"yucunxu",age:27)
        
        print(v1)
        print(v2)
        print(v3)
        print(v4)
        print(v5)
        print(v6)
        print(v7.name)
        print(v7.age)
        let p1 = 1
        if p1==1 {
            print("123456")
        }
        
        let arr = ["11","22","33","44","55","66"]
        for i in 0..<arr.count {
            print(i,arr[i])
        }
        
        print("枚举SomeType==\(SomeType.SomeTypeOne)")
        let myStruct = MyStructTest()
        let myStruct2 = MyStructTest(originX: 50, originY: 60, width: 70, height: 80)
        var myStruct3 = myStruct2
        myStruct3.width = 500
        print("myStruct.width==\(myStruct.width)")
        print("myStruct2.width==\(myStruct2.width)")
        print("myStruct3.width==\(myStruct3.width)")

        checkUp(person: ["id":"123456789","zkz":"khjsalgkuhiglsad "])

    }
    
    func checkUp(person:[String:String?]) {
        guard let id = person["id"] else {
            print("没有身份证")
            return
        }
        guard let zkz = person["zkz"] else {
            print("没有准考证")
            return
        }
        print("身份证==\(id!),准考证\(zkz!)")
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
