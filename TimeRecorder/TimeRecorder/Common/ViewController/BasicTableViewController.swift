//
//  BasicTableViewController.swift
//  TimeRecorder
//  A basic tableViewController with nav bar and tab bar
//  Created by Leo Zhou on 2019/3/19.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class BasicTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    var showTabBar: Bool = true
    
    init(title: String, showTabBar: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.showTabBar = showTabBar
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.isTranslucent = false
        
        let backButton = UIBarButtonItem(
            title: self.title,
            style: .plain,
            target: self,
            action: #selector(BasicTableViewController.back))
        self.navigationItem.backBarButtonItem = backButton
        
        let screenSize = UIScreen.main.bounds.size
        var tableViewHeight = screenSize.height
        if showTabBar {
            tableViewHeight = tableViewHeight - self.tabBarController!.tabBar.frame.height
        }
        let tableView = UITableView(
            frame: CGRect(x: 0, y: 0, width: screenSize.width,height: tableViewHeight),
            style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        self.tableView = tableView
        self.view.addSubview(tableView)
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = !showTabBar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)-> CGFloat {
        return 50
    }

}