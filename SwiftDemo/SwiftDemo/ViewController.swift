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
        
//        print("kScreenWidth==\(kScreenWidth)")
//        print("kScreenHeight==\(kScreenHeight)")
//        print("kStatusBarHeight==\(kStatusBarHeight)")
        print("kBarHeight==\(kBarHeight)")
        print("kNavBarHeight==\(kNavBarHeight)")

        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        scrollView.backgroundColor = UIColor.white
        scrollView.contentSize = CGSize(width: kScreenWidth, height: kScreenHeight*2)
        self.view.addSubview(scrollView)
        
        let dataTypeBtn = UIButton(type: .custom)
        dataTypeBtn.frame = CGRect(x: 20, y: 30, width: kScreenWidth-40, height: 40)
        dataTypeBtn.backgroundColor = UIColor.green
        dataTypeBtn.setTitle("基本数据类型", for: .normal)
        dataTypeBtn.setTitleColor(UIColor.red, for: .normal)
        dataTypeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        dataTypeBtn.addTarget(self, action: #selector(dataTypeBtnClick(sender:)), for: .touchUpInside)
        dataTypeBtn.addTarget(self, action: #selector(dataTypeBtnClick(sender:)), for: .touchUpInside)
        scrollView.addSubview(dataTypeBtn)
        
        let viewBtn = UIButton(type: .custom)
        viewBtn.frame = CGRect(x: 20, y: dataTypeBtn.frame.origin.y+dataTypeBtn.frame.size.height+20, width: kScreenWidth-40, height: 40)
        viewBtn.backgroundColor = UIColor.green
        viewBtn.setTitle("UIView", for: .normal)
        viewBtn.setTitleColor(UIColor.red, for: .normal)
        viewBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        viewBtn.addTarget(self, action: #selector(viewBtnClick(sender:)), for: .touchUpInside)
        scrollView.addSubview(viewBtn)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 20, y: viewBtn.frame.origin.y+viewBtn.frame.size.height+20, width: kScreenWidth-40, height: 40)
        button.backgroundColor = UIColor.green
        button.setTitle("UIButton", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        scrollView.addSubview(button)
        
        let labelBtn = UIButton(type: .custom)
        labelBtn.frame = CGRect(x: 20, y: button.frame.origin.y+button.frame.size.height+20, width: kScreenWidth-40, height: 40)
        labelBtn.backgroundColor = UIColor.green
        labelBtn.setTitle("UILabel", for: .normal)
        labelBtn.setTitleColor(UIColor.red, for: .normal)
        labelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        labelBtn.addTarget(self, action: #selector(labelBtnClick(sender:)), for: .touchUpInside)
        scrollView.addSubview(labelBtn)
        
        let imageBtn = UIButton(type: .custom)
        imageBtn.frame = CGRect(x: 20, y: labelBtn.frame.origin.y+labelBtn.frame.size.height+20, width: kScreenWidth-40, height: 40)
        imageBtn.backgroundColor = UIColor.green
        imageBtn.setTitle("UIImageView", for: .normal)
        imageBtn.setTitleColor(UIColor.red, for: .normal)
        imageBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        imageBtn.addTarget(self, action: #selector(imageBtnClick(sender:)), for: .touchUpInside)
        scrollView.addSubview(imageBtn)
        
        let scrollBtn = UIButton(type: .custom)
        scrollBtn.frame = CGRect(x: 20, y: imageBtn.frame.origin.y+imageBtn.frame.size.height+20, width: kScreenWidth-40, height: 40)
        scrollBtn.backgroundColor = UIColor.green
        scrollBtn.setTitle("UIScrollView", for: .normal)
        scrollBtn.setTitleColor(UIColor.red, for: .normal)
        scrollBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        scrollBtn.addTarget(self, action: #selector(scrollBtnClick(sender:)), for: .touchUpInside)
        scrollView.addSubview(scrollBtn)
        
        let textFieldBtn = UIButton(type: .custom)
        textFieldBtn.frame = CGRect(x: 20, y: scrollBtn.frame.origin.y+scrollBtn.frame.size.height+20, width: kScreenWidth-40, height: 40)
        textFieldBtn.backgroundColor = UIColor.green
        textFieldBtn.setTitle("UITextField", for: .normal)
        textFieldBtn.setTitleColor(UIColor.red, for: .normal)
        textFieldBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        textFieldBtn.addTarget(self, action: #selector(textFieldBtnClick(sender:)), for: .touchUpInside)
        scrollView.addSubview(textFieldBtn)
        
        let alertBtn = UIButton(type: .custom)
        alertBtn.frame = CGRect(x: 20, y: textFieldBtn.frame.origin.y+textFieldBtn.frame.size.height+20, width: kScreenWidth-40, height: 40)
        alertBtn.backgroundColor = UIColor.green
        alertBtn.setTitle("Alert", for: .normal)
        alertBtn.setTitleColor(UIColor.red, for: .normal)
        alertBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        alertBtn.addTarget(self, action: #selector(alertBtnClick(sender:)), for: .touchUpInside)
        scrollView.addSubview(alertBtn)

    }
    
    @objc func dataTypeBtnClick(sender:UIButton) {
        print("基本数据类型")
        let baseDataVC = BaseDataTypeController()
        self.navigationController?.pushViewController(baseDataVC, animated: true)
        
    }
    
    @objc func viewBtnClick(sender:UIButton) {
        print("view")
        let buttonVC = BaseViewController()
        self.navigationController?.pushViewController(buttonVC, animated: true)
    }
    
    @objc func buttonClick(sender:UIButton) {
        print("按钮")
        let buttonVC = ButtonViewController()
        self.navigationController?.pushViewController(buttonVC, animated: true)
    }
    
    @objc func labelBtnClick(sender:UIButton) {
        print("label")
        let buttonVC = LabelViewController()
        self.navigationController?.pushViewController(buttonVC, animated: true)
        
    }
    
    @objc func imageBtnClick(sender:UIButton) {
        print("image")
        let buttonVC = ImageViewController()
        self.navigationController?.pushViewController(buttonVC, animated: true)
    }
    
    @objc func scrollBtnClick(sender:UIButton) {
        print("scroll")
        let buttonVC = ScrollViewController()
        self.navigationController?.pushViewController(buttonVC, animated: true)
    }
    
    @objc func textFieldBtnClick(sender:UIButton) {
        print("textField")
        let buttonVC = TextFieldViewController()
        self.navigationController?.pushViewController(buttonVC, animated: true)
    }
    
    @objc func alertBtnClick(sender:UIButton) {
        print("alert")
        let buttonVC = AlertViewController()
        self.navigationController?.pushViewController(buttonVC, animated: true)
    }
    

    
}

