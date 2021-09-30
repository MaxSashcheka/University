//
//  Extensions.swift
//  University
//
//  Created by Max Sashcheka on 9/30/21.
//

import UIKit

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        return ceil(size.width)
    }
}
