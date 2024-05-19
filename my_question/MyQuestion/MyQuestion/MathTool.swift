//
//  MathTool.swift
//  MyQuestion
//
//  Created by oker on 2024/5/20.
//

import UIKit

class MathTool: NSObject {
    public static func getHeight(for text: String, width: CGFloat, font: UIFont) -> CGFloat {
            let originSize = CGSize(width: width, height: CGFLOAT_MAX)
            let label = UILabel()
            label.font = font
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.text = text
            let size = label.sizeThatFits(originSize)
            return ceil(size.height)

    //        let constraintSize = CGSize(width: width, height: .greatestFiniteMagnitude)
    //        let boundingBox = text.boundingRect(with: constraintSize,
    //                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
    //                                            attributes: [NSAttributedString.Key.font: font],
    //                                            context: nil)
    //        return ceil(boundingBox.height)
        }
}
