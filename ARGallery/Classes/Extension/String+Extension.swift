//
//  String+Extension.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import UIKit

extension String {
    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    func textWithLineSpace(lineSpacing: CGFloat = 5) -> NSAttributedString? {
        let attrString = NSMutableAttributedString(string: self)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: self.count))
        return attrString
    }
}
