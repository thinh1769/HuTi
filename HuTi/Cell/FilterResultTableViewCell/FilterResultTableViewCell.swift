//
//  FilterResultTableViewCell.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import UIKit

class FilterResultTableViewCell: UITableViewCell {

    @IBOutlet private weak var postImage: UIImageView!
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(_  post: Post, isHiddenAuthorAndHeart: Bool) {
        postTitleLabel.text = post.title
        priceLabel.text = post.price
        addressLabel.text = post.address
        authorLabel.text = post.authorName
        
        if isHiddenAuthorAndHeart {
            bottomView.isHidden = true
            addressLabel.numberOfLines = 0
        }
    }
    
}
