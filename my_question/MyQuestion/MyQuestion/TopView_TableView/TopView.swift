//
//  TopView.swift
//  MyQuestion
//
//  Created by oker on 2024/6/14.
//

import UIKit

class TopView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let leftView = UIView(frame: .zero)
        let rightView = UIView(frame: .zero)
        self.addSubview(leftView)
        self.addSubview(rightView)
        
        leftView.backgroundColor = .blue
        rightView.backgroundColor = .red
        
        leftView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.equalTo(self.snp.leading).offset(-(self.bounds.width * 0.25))
        }
        
        rightView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(leftView.snp.trailing)
        }
        
        let leftLabel = UILabel(frame: .zero)
        leftLabel.text = "Swift实现一个大视图，包含左右两个视图，左视图占四分之三，右视图占四分之一，大视图的宽度是屏幕宽度，高度取决于左右两个视图中高的。"
        let rightLabel = UILabel(frame: .zero)
        leftLabel.text = "右视图随机高度，但宽度占屏幕的四分之一。左右两个视图撑起整个顶部视图，且顶部视图的高度是左右视图中高度最大的。宽度是屏幕宽度"
        leftView.addSubview(leftLabel)
        rightView.addSubview(rightLabel)
        
        leftLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        rightLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
