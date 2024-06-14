//
//  TopViewTableViewVC.swift
//  MyQuestion
//
//  Created by oker on 2024/6/14.
//

import UIKit
import SnapKit

class TopViewTableViewVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var tableview: UITableView = {
        var tmp = UITableView(frame: .zero, style: .plain)
        tmp.delegate = self
        tmp.dataSource = self
        tmp.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        return tmp
    }()
    
    private let dataSource = ["订单1", "订单2", "订单3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

}

extension TopViewTableViewVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
