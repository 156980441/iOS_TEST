//
//  LabelImageVC.swift
//  MyQuestion
//
//  Created by oker on 2024/5/19.
//

import UIKit

class LabelImageVC: UIViewController {
    
    func getLabel(_ text: String)->UILabel {
        let tmp = UILabel.init(frame: .zero)
        tmp.text = text
        tmp.numberOfLines = 0
        return tmp
    }
    
    func getImageView()->UIImageView {
        let tmp = UIImageView.init(frame: .zero)
        tmp.image = UIImage(named: "num_1")
        return tmp
    }
    
    override func viewDidLoad() {
        let view1 = UIView.init(frame: .zero)
        view1.backgroundColor = .yellow
        view.addSubview(view1)
        view1.snp.makeConstraints { make in
            make.top.equalTo(view).offset(100)
            make.leading.equalTo(view)
            make.size.equalTo(CGSizeMake(100, 100))
        }
        
        let lbl = getLabel("短文字")
        let imageV = getImageView()
        view1.addSubview(lbl)
        view1.addSubview(imageV)
        lbl.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.lessThanOrEqualTo(imageV.snp.leading)
        }
        imageV.snp.makeConstraints { make in
            make.centerY.equalTo(lbl)
            make.leading.equalTo(lbl.snp.trailing)
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.trailing.lessThanOrEqualTo(view1.snp.trailing)
        }
        
        let view2 = UIView.init(frame: .zero)
        view2.backgroundColor = .yellow
        view.addSubview(view2)
        view2.snp.makeConstraints { make in
            make.top.equalTo(view1.snp.bottom).offset(10)
            make.leading.equalTo(view)
            make.size.equalTo(CGSizeMake(200, 200))
        }
        
        let lbl2 = getLabel("长文字折行长文字折行长文字折行长文字折行长文字折行长文字折行长文字折行长文字折行")
        let imageV2 = getImageView()
        view2.addSubview(lbl2)
        view2.addSubview(imageV2)
        lbl2.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.lessThanOrEqualTo(imageV2.snp.leading)
        }
        imageV2.snp.makeConstraints { make in
            make.centerY.equalTo(lbl2)
            make.leading.equalTo(lbl2.snp.trailing)
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.trailing.lessThanOrEqualTo(view2.snp.trailing)
        }
    }
}
