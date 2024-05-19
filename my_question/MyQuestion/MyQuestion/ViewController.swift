//
//  ViewController.swift
//  MyQuestion
//
//  Created by oker on 2024/5/11.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var tableview: UITableView = {
        var tmp = UITableView(frame: .zero, style: .plain)
        tmp.delegate = self
        tmp.dataSource = self
        tmp.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        return tmp
    }()
    
    private let dataSource = ["文字+图片样式，可折行，图片左贴文字", "UITableView 在顶部加入View，利用偏移"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nav = UINavigationController(rootViewController: <#T##UIViewController#>)
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = LabelImageVC.init()
            
        }
        if indexPath.row == 1 {
            
        }
    }
}

