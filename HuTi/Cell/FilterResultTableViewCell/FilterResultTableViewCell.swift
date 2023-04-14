//
//  FilterResultTableViewCell.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import UIKit
import SDWebImage

class FilterResultTableViewCell: UITableViewCell {

    @IBOutlet private weak var thumbnail: UIImageView!
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var heartBtn: UIImageView!
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
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
        self.selectionStyle = .none
        cellView.layer.cornerRadius = 10
        heartBtn.image = UIImage(systemName: "heart")
        heartBtn.tintColor = UIColor(named: ColorName.gray)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configInfo(_  post: Post, isHiddenAuthorAndHeart: Bool, isFavorite: Bool?) {
        postTitleLabel.text = post.title
        priceLabel.text = String(post.price)
        addressLabel.text = post.getFullAddress()
        authorLabel.text = "Đăng bởi \(post.userName.getName())"
        
        if let url = URL(string: "\(AWSConstants.objectURL)\(post.thumbnail)") {
            thumbnail.sd_setImage(with: url, placeholderImage: nil, options: [.retryFailed, .scaleDownLargeImages], context: [.imageThumbnailPixelSize: CGSize(width: thumbnail.bounds.width * UIScreen.main.scale, height: thumbnail.bounds.height * UIScreen.main.scale)])
        }
        
        if isHiddenAuthorAndHeart {
            bottomView.isHidden = true
            addressLabel.numberOfLines = 0
        }
        
        if let userId = UserDefaults.userInfo?.id,
           userId == post.userId {
            heartBtn.isHidden = true
        } else if let isFavorite = isFavorite {
                if !isFavorite  {
                    heartBtn.image = UIImage(systemName: "heart")
                    heartBtn.tintColor = UIColor(named: ColorName.gray)
                } else {
                    heartBtn.image = UIImage(systemName: "heart.fill")
                    heartBtn.tintColor = UIColor(named: ColorName.redStatusText)
                }
        }
        
        self.thumbnail.image = nil
    }
    
    func loadThumbnail(thumbnail: UIImage) {
        self.thumbnail.image = thumbnail
    }
    
}
