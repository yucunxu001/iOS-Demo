//
//  LabelViewController.swift
//  SwiftDemo
//
//  Created by mkrq-yh on 2019/3/12.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit

class LabelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initPages()
    }
    func initPages() {
        self.navigationItem.title = "UILabel基本用法";
        self.view.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 20, y: kBarHeight+20, width: kScreenWidth-40, height: 200))
        label.text = "这是swift中的UILabel控件的基本使用\n这是swift中的UILabel控件的基本使用\n这是swift中的UILabel控件的基本使用"
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor.green
        label.numberOfLines = 0
        self.view.addSubview(label)
        
        let textAtt = NSMutableAttributedString(string: "AAABBBCCC\n雷克萨大公鸡经历过；就萨迪了卡萨丁GV雷克萨的感觉撒都挂机哦isadd雷克萨的感觉哦萨达刚就萨达刚进来凯撒股份金佛sad你的空间sad过女撒过或扩啦所多过多卡军过哈付付付付付付风哈多不过拉克丝独孤伽罗卡萨丁股东按规划那大概俺三个电话你看撒大哥好看啊")
        textAtt.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 0, length: textAtt.length))
        textAtt.addAttribute(.font, value: UIFont.systemFont(ofSize: 30), range: NSRange(location: 0, length: 3))
        textAtt.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: NSRange(location: 3, length: 3))
        textAtt.addAttribute(.font, value: UIFont.systemFont(ofSize: 10), range: NSRange(location: 6, length: 3))
        textAtt.addAttribute(.foregroundColor, value: UIColor.green, range: NSRange(location: 0, length: 3))
        textAtt.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 3, length: 3))
        textAtt.addAttribute(.foregroundColor, value: UIColor.yellow, range: NSRange(location: 6, length: 3))
        let textSize = textAtt.boundingRect(with: CGSize(width: kScreenWidth, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil).size
        
        let label2 = UILabel(frame: CGRect(x: 0, y: label.frame.origin.y+label.frame.size.height+20, width: kScreenWidth, height: textSize.height))
        label2.backgroundColor = UIColor.lightGray
        label2.numberOfLines = 0
        label2.attributedText = textAtt
        self.view.addSubview(label2)
        
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
