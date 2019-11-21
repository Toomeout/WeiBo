//
//  HomeTableViewController.swift
//  Weibo
//
//  Created by 李喜明 on 2019/10/31.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh
class HomeTableViewController: BaseViewController {

    let titleBtn: TitleButton = TitleButton()
    
    private lazy var popoverAnimator:  PopoverAnimator = PopoverAnimator { [weak self] (isPop) in
        self?.titleBtn.isSelected = isPop
    }
    private lazy var statuses: [StatusViewModel] = [StatusViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView.addRotateAnimate()
        guard isLogin else {
            return
        }
        //登录后设置导航栏l内容
        setUpNavigstion()
        loadStatuses(isNew: true)
        tableView.register(UINib.init(nibName: "HomeCell", bundle: .main), forCellReuseIdentifier: "homeCell")//使用xib方式注册cell名字要和xib中的一样
        
        //refreshControl = UIRefreshControl()//苹果刷新控制器
        setUpHeaderView()//设置刷新头
        setUpFooterView()//设置加载更多
    }
}
//设置home界面的navigation的UI
extension HomeTableViewController {
    //设置登录后的navigation内容
    private func setUpNavigstion() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: "navigationbar_pop")
        titleBtn.setTitle("coderwhy", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
        navigationItem.titleView = titleBtn
        
    }
    private func setUpFooterView() {
        let footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreStatus))
        tableView.mj_footer = footer
        tableView.mj_footer?.beginRefreshing()//进入刷新
        
    }
    private func setUpHeaderView() {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewStatus))
        header.setTitle("下拉刷新", for: .idle)
        header.setTitle("释放刷新", for: .pulling)
        header.setTitle("加载中...", for: .refreshing)
        tableView.mj_header = header
        tableView.mj_header?.beginRefreshing()//进入刷新
    }
}
//监听方法
extension HomeTableViewController {
    @objc private func titleBtnClick(titleButton: TitleButton) {
        titleButton.isSelected = !titleButton.isSelected
        let popView = PopViewController()
        popView.modalPresentationStyle = .custom//保证跳转视图的底层视图不被移除
        popView.transitioningDelegate = popoverAnimator//设置转场代理实现自定义转场
        popoverAnimator.popViewFrame = CGRect(x: 100, y: 80, width: 200, height: 250)
        present(popView, animated: true, completion: nil)
    }
    @objc private func loadNewStatus() {
        loadStatuses(isNew: true)//刷新请求数据
    }
    @objc private func loadMoreStatus() {
        loadStatuses(isNew: false)//刷新更多数据
    }
}
//请求数据
extension HomeTableViewController {
    private func loadStatuses(isNew: Bool) {
        var since_id = 0
        var max_id = 0
        if isNew {
            since_id = statuses.first?.status?.mid ?? 0
        } else {
            max_id = statuses.last?.status?.mid ?? 0
            max_id = max_id == 0 ? max_id : max_id - 1
        }
        NetWorkTool.shareInstance.loadStatus(since_id: since_id, max_id: max_id) {(result, error) in
            if error != nil {
                return
            }
            guard let resultArray = result else {
                print("没有获取资源")
                return
            }
            
            var tempArr = [StatusViewModel]()
            for status in resultArray {
                let statusModel = StatusViewModel(status: Status(dict: status))
                tempArr.append(statusModel)
            }
            
            if isNew {
                self.statuses = tempArr + self.statuses//将刷星的微博拼接
            } else {
                self.statuses = self.statuses + tempArr//拼接更多微博
            }
            self.cacheImages(viewModel: tempArr)//缓存图片
        }
    }
    private func cacheImages(viewModel: [StatusViewModel]) {
        //创建组
        let group = DispatchGroup()
        //缓存图片
        for arrItem in viewModel {
            for url in arrItem.picUrls {
                group.enter()//加入组
                SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { (_, _, _, _, _, _) in
                    //异步下载
                    group.leave()//下载完成离开组
                }
            }
        }
        group.notify(queue: DispatchQueue.main) {
            self.tableView.reloadData() //在主队列中刷星数据
            self.tableView.mj_header?.endRefreshing()//加载w完新的数据后停止刷新动作
            self.tableView.mj_footer?.endRefreshing()
        }
    }

}

extension HomeTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell") as! HomeCell
        cell.viewModel = statuses[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected\(indexPath.row)")
    }
}
