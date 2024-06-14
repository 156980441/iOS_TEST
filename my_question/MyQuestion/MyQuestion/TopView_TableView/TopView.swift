//
//  TopView.swift
//  MyQuestion
//
//  Created by oker on 2024/6/14.
//

import UIKit

class TopView: UIView {
    private let leftView = UIView()
    private let rightView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(leftView)
        addSubview(rightView)
        
        leftView.backgroundColor = .blue
        rightView.backgroundColor = .red
        
        let leftLabel = UILabel(frame: .zero)
        leftLabel.numberOfLines = 0
        leftLabel.text = "Swift实现一个大视图，包含左右两个视图，左视图占四分之三，右视图占四分之一，大视图的宽度是屏幕宽度，高度取决于左右两个视图中高的。"
        let rightLabel = UILabel(frame: .zero)
        rightLabel.numberOfLines = 0
        rightLabel.text = "右视图随机高度，但宽度占屏幕的四分之一。左右两个视图撑起整个顶部视图，且顶部视图的高度是左右视图中高度最大的。宽度是屏幕宽度"
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
    
    // 这样可以确保 view 的大小已经确定,我们可以根据 view 的大小设置约束。
    override func layoutSubviews() {
        /**
         如果将 leftView 和 rightView 都设置 bottom.equalToSuperview()，那么 containerView 的高度最终将依赖于 leftView 和 rightView 中高度较大的那个。
         
         具体来说:
         
         如果 leftView 的高度大于 rightView，那么 containerView 的高度将等于 leftView 的高度。
         如果 rightView 的高度大于 leftView，那么 containerView 的高度将等于 rightView 的高度。
         如果 leftView 和 rightView 的高度相等,那么 containerView 的高度将等于两者的高度。
         这是因为在 Auto Layout 中,子视图的 bottom 约束会传递给父视图,使父视图的高度自适应于较高的子视图。
         */
        
        // 设置左侧视图的约束
        leftView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.equalTo(self.snp.trailing).offset(-(self.bounds.width * 0.25))
        }
        
        // 设置右侧视图的约束
        rightView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(leftView.snp.trailing)
        }
    }
}
