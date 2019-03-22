//
//  FactoryViewController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/21.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class FactoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "工厂"
        
        let animal = FactoryAnimal()
        let dog = animal.createObject(className: "Dog")
        dog.printClassName()
        let cat = animal.createObject(className: "Cat")
        cat.printClassName()
                
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
