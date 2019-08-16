//
//  MusicListViewModel.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/16.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

//歌曲结构体
struct Music {
    let name: String //歌名
    let singer: String //演唱者
    
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

//实现 CustomStringConvertible 协议，方便输出调试
extension Music: CustomStringConvertible {
    var description: String {
        return "name：\(name) singer：\(singer)"
    }
}

////歌曲列表数据源
//struct MusicListViewModel {
//    let data = [
//        Music(name: "无条件", singer: "陈奕迅"),
//        Music(name: "你曾是少年", singer: "S.H.E"),
//        Music(name: "从前的我", singer: "陈洁仪"),
//        Music(name: "在木星", singer: "朴树"),
//    ]
//}

//歌曲列表数据源
struct MusicListViewModel {
    let data = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
        ])
}
