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
    @IBOutlet weak var bottomBrowseView: UIView!
    @IBOutlet weak var browseStatusView: UIView!
    @IBOutlet weak var browseStatusLabel: UILabel!
    @IBOutlet weak var hiddenStatusView: UIView!
    
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
        hiddenStatusView.layer.cornerRadius = 10
        hiddenStatusView.isHidden = true
        heartBtn.isHidden = false
        bottomBrowseView.isHidden = true
        heartBtn.image = UIImage(systemName: "heart")
        heartBtn.tintColor = UIColor(named: ColorName.gray)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configInfo(_  post: Post, isHiddenAuthorAndHeart: Bool, isFavorite: Bool?) {
        if let status = post.status {
            if status == 0 {
                hiddenStatusView.isHidden = true
            } else {
                hiddenStatusView.isHidden = false
            }
        }
        postTitleLabel.text = post.title
        priceLabel.text = "\((post.price).formattedWithSeparator)đ"
        addressLabel.text = post.getFullAddress()
        authorLabel.text = "Đăng bởi \(post.userName.getName())"
        
        if let url = URL(string: "\(AWSConstants.objectURL)\(post.thumbnail)") {
            thumbnail.sd_setImage(with: url, placeholderImage: nil, options: [.retryFailed, .scaleDownLargeImages], context: [.imageThumbnailPixelSize: CGSize(width: thumbnail.bounds.width * UIScreen.main.scale, height: thumbnail.bounds.height * UIScreen.main.scale)])
        }
        
        if isHiddenAuthorAndHeart {
            bottomView.isHidden = true
            bottomBrowseView.isHidden = false
            addressLabel.numberOfLines = 0
            configBrowseStatusView(post.browseStatus ?? 0)
            
        }
        
        if let userId = UserDefaults.userInfo?.id,
           userId == post.userId {
            heartBtn.isHidden = true
        } else if let isFavorite = isFavorite {
            heartBtn.isHidden = false
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
    
    private func configBrowseStatusView(_ status: Int) {
        switch status {
        case 2:
            browseStatusView.backgroundColor = UIColor(named: ColorName.redStatusBackground)
            browseStatusLabel.textColor = UIColor(named: ColorName.redStatusText)
            browseStatusLabel.text = "Bị từ chối"
        case 1:
            browseStatusView.backgroundColor = UIColor(named: ColorName.greenStatusBackground)
            browseStatusLabel.textColor = UIColor(named: ColorName.greenStatusText)
            browseStatusLabel.text = "Đã duyệt"
        case 0:
            browseStatusView.backgroundColor = UIColor(named: ColorName.purpleStatusBackground)
            browseStatusLabel.textColor = UIColor(named: ColorName.purpleStatusText)
            browseStatusLabel.text = "Chờ duyệt"
        default:
            return
        }
    }
    
}
