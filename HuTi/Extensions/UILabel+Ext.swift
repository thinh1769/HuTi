//
//  UILabel+Ext.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 05/05/2023.
//

import UIKit

extension UILabel {
    func requiredLabel() -> NSAttributedString {
        let asteriskText = "*"
        let attributedText = NSMutableAttributedString(string: self.text ?? "")
        let asteriskAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
        let asteriskAttributedString = NSAttributedString(string: asteriskText, attributes: asteriskAttributes)
        attributedText.append(asteriskAttributedString)
        return attributedText
    }
}
