//
//  TestViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/16.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//class TestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
class TestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
//    let musicListViewModel = MusicListViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // 设置代理
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return musicListViewModel.data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell")!
//        let music = musicListViewModel.data[indexPath.row]
//        cell.textLabel?.text = music.name
//        cell.detailTextLabel?.text = music.singer
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("你选中的歌曲信息【\(musicListViewModel.data[indexPath.row])】")
//    }
    
    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()
    
    //负责对象销毁
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //将数据源数据绑定到tableView上
        musicListViewModel.data
            .bind(to: tableView.rx.items(cellIdentifier:"musicCell")) { _, music, cell in
                cell.textLabel?.text = music.name
                cell.detailTextLabel?.text = music.singer
            }.disposed(by: disposeBag)
        
        //tableView点击响应
        tableView.rx.modelSelected(Music.self).subscribe(onNext: { music in
            print("你选中的歌曲信息【\(music)】")
        }).disposed(by: disposeBag)
    }
}

