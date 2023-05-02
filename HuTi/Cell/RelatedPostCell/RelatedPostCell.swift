//
//  RelatedPostCellCollectionViewCell.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 12/04/2023.
//

import UIKit
import SDWebImage

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
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
    }
    
    func config(_ post: Post) {
        titleLabel.text = post.title
        priceLabel.text = "\((post.price).formattedWithSeparator)đ"
        acreageLabel.text = "\(post.acreage ?? 0)m2"
        
        if let url = URL(string: "\(AWSConstants.objectURL)\(post.thumbnail)") {
            thumbnail.sd_setImage(with: url, placeholderImage: nil, options: [.retryFailed, .scaleDownLargeImages], context: [.imageThumbnailPixelSize: CGSize(width: thumbnail.bounds.width * UIScreen.main.scale, height: thumbnail.bounds.height * UIScreen.main.scale)])
        }
    }
}
