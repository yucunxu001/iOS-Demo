//
//  TextFieldViewController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/12.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class TextFieldViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initPages()
    }
    
    func initPages() {
        self.navigationItem.title = "UITextField基本用法";
        self.view.backgroundColor = UIColor.white
        
        let textField = UITextField(frame: CGRect(x: 20, y: kBarHeight+100, width: kScreenWidth-40, height: 40))
        textField.backgroundColor = UIColor.lightGray
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder = "请输入内容"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.search
        textField.textColor = UIColor.red
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.becomeFirstResponder()
        textField.addTarget(self, action: #selector(textFieldChanged(textField:)), for: .editingChanged)
        self.view.addSubview(textField)
        
    }
    //MARK: 整个页面结束编辑
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: 是否可以编辑 默认true,return false不可以编辑
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    //MARK: 失去焦点时 返回是否停止编辑 false一直编辑 默认true结束编辑
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    //MARK: 开始编辑
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NSLog("开始编辑")
    }
    
    //MARK: 结束编辑
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("结束编辑 textFieldDidEndEditing")
    }
    
    //MARK: 点击retun键
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("点击retun键==\(textField.text!)")
        return true
    }
    
    //MARK: 监听textField的值变化
    @objc func textFieldChanged(textField: UITextField) {
        print(textField.text!)
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
