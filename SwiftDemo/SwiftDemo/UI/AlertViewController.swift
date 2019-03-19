//
//  AlertViewController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/12.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initPages()
    }
    
    func initPages() {
        self.navigationItem.title = "Alert基本用法";
        self.view.backgroundColor = UIColor.white
        
        let alertBtn = UIButton(type: .custom)
        alertBtn.frame = CGRect(x: 20, y: kBarHeight+20, width: kScreenWidth-40, height: 40)
        alertBtn.backgroundColor = UIColor.green
        alertBtn.setTitle("Alert", for: .normal)
        alertBtn.setTitleColor(UIColor.red, for: .normal)
        alertBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        alertBtn.addTarget(self, action: #selector(alertBtnClick(sender:)), for: .touchUpInside)
        self.view.addSubview(alertBtn)
        
        let sheetBtn = UIButton(type: .custom)
        sheetBtn.frame = CGRect(x: 20, y: alertBtn.frame.origin.y+alertBtn.frame.size.height+20, width: kScreenWidth-40, height: 40)
        sheetBtn.backgroundColor = UIColor.green
        sheetBtn.setTitle("sheet", for: .normal)
        sheetBtn.setTitleColor(UIColor.red, for: .normal)
        sheetBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sheetBtn.addTarget(self, action: #selector(sheetBtnClick(sender:)), for: .touchUpInside)
        self.view.addSubview(sheetBtn)
    }

    @objc func alertBtnClick(sender: UIButton) {
        let alert = UIAlertController(title: "Swift开发？", message: "这是Swift吗？", preferredStyle: .alert)
        let cancle = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let query = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
            print("确定")
        }
        alert.addAction(cancle)
        alert.addAction(query)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func sheetBtnClick(sender: UIButton) {
        let sheet = UIAlertController(title: "选择图片", message: nil, preferredStyle: .actionSheet)
        let cancle = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let type1 = UIAlertAction(title: "相机", style: .default) { (UIAlertAction) in
            print("相机")
        }
        let type2 = UIAlertAction(title: "相册", style: .default) { (UIAlertAction) in
            print("相册")
        }
        let type3 = UIAlertAction(title: "保存", style: .default) { (UIAlertAction) in
            print("保存")
        }
        sheet.addAction(cancle)
        sheet.addAction(type1)
        sheet.addAction(type2)
        sheet.addAction(type3)
        
        self.present(sheet, animated: true, completion: nil)
        
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
