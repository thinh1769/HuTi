//
//  AddressCollectionViewCell.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import UIKit

class AddressCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
//        self.backgroundColor = .clear
    }
    
    func config(content: String) {
        contentLabel.text = content
    }
}
