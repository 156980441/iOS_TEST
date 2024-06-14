//
//  TopViewVC.swift
//  MyQuestion
//
//  Created by oker on 2024/6/14.
//

import UIKit

class TopViewVC: UIViewController {
    private let topView = TopView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topView)
        let safeArea = view.safeAreaLayoutGuide
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeArea)
        }
    }
}
