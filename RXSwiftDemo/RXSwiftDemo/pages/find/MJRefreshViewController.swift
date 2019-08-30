//
//  MJRefreshViewController.swift
//  RXSwiftDemo
//
//  Created by mkrq-yh on 2019/8/30.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

import UIKit
import Kingfisher

class MJRefreshViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView : UITableView!
    var items : [String]!
    var page:Int!
    var totalPage:Int!
    
    let header = MJRefreshNormalHeader()
    let footer = MJRefreshBackNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        page = 1
        totalPage = 3
        items = []
        
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor = UIColor.white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
        
//        header.setRefreshingTarget(self, refreshingAction: #selector(MJRefreshViewController.headerRefresh))
//        self.tableView.mj_header = header
//        footer.setRefreshingTarget(self, refreshingAction: #selector(MJRefreshViewController.footerRefresh))
//        self.tableView.mj_footer = footer
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            print("下拉刷新.")
            sleep(2)
            //重现生成数据
            self.getItems()
            //重现加载表格数据
            self.tableView!.reloadData()
            //结束刷新
            self.tableView!.mj_header.endRefreshing()
        })
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            print("上拉加载")
            sleep(2)
            //重现生成数据
            self.getItems()
            //重现加载表格数据
            self.tableView!.reloadData()
            //结束刷新
            self.tableView!.mj_footer.endRefreshing()
        })
        self.tableView.mj_header.beginRefreshing()
    }
    
    //下拉刷新
    @objc func headerRefresh() {
        print("下拉刷新.")
        items = []
        sleep(2)
        //重现生成数据
        getItems()
        //重现加载表格数据
        self.tableView!.reloadData()
        //结束刷新
        self.tableView!.mj_header.endRefreshing()
    }
    
    //下拉刷新
    @objc func footerRefresh() {
        print("上拉加载")
        sleep(2)
        //重现生成数据
        getItems()
        //重现加载表格数据
        self.tableView!.reloadData()
        //结束刷新
        self.tableView!.mj_footer.endRefreshing()
    }
    
    func getItems() {
        if page == 1 {
            items = []
        } else if page > totalPage {
            print("没有数据了")
            self.tableView.mj_footer.state = .noMoreData
            return
        }
        page += 1
        for _ in 0...9 {
            self.items.append("条目\(Int(arc4random()))")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = items[indexPath.row]
        return cell
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
