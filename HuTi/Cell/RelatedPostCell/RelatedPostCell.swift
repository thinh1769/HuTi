//
//  RelatedPostCellCollectionViewCell.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 12/04/2023.
//

import UIKit

class RelatedPostCell: UICollectionViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var acreageLabel: UILabel!
    
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
        thumbnail.image = nil
    }
    
    func config(_ post: Post) {
        titleLabel.text = post.title
        priceLabel.text = "\(post.price)VNĐ"
    }
    
    func loadThumbnail(_ thumbnail: UIImage) {
        self.thumbnail.image = thumbnail
    }

}
