//
//  BackButton.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 17/03/2023.
//

import UIKit

final class BackButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        clipsToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        setImage(UIImage(systemName: ImageName.backButton), for: .normal)
        
        tintColor = UIColor(named: ColorName.black)
        backgroundColor = UIColor(named: ColorName.white)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
