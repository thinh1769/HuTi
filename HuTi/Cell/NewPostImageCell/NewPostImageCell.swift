//
//  NewPostImageCell.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 02/04/2023.
//

import UIKit

class NewPostImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
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
        imageView.layer.cornerRadius = 5
    }
    
    func config(image: UIImage) {
        imageView.image = image
    }

}
