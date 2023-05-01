//
//  DetailPopupView.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 09/04/2023.
//

import UIKit
import SDWebImage

protocol DetailPopupViewDelegate: AnyObject {
    func deselectedAnnotationWhenDismissDetailPopup()
    
    func onClickedPostDetailButton(_ postId: String)
}

class DetailPopupView: UIView {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    
    private let viewModel = DetailPopupViewModel()
    weak var delegate: DetailPopupViewDelegate?
    
    func configHeartIcon(_ isFavorite: Bool) {
        viewModel.isFavorite = isFavorite
    }
    
    var nibName: String {
        return String(describing: DetailPopupView.self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
        setupSubView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        nibSetup()
        setupSubView()
    }
    
    private func setupSubView() {
        addPanGestureToDetailPopup()
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor(named: ColorName.gray)?.cgColor
        self.layer.borderWidth = 1
        thumbnail.image = nil
    }
    
    func loadData(_ post: Post) {
        viewModel.post = post
        
        if let url = URL(string: "\(AWSConstants.objectURL)\(post.thumbnail)") {
            thumbnail.sd_setImage(with: url, placeholderImage: nil, options: [.retryFailed, .scaleDownLargeImages], context: [.imageThumbnailPixelSize: CGSize(width: thumbnail.bounds.width * UIScreen.main.scale, height: thumbnail.bounds.height * UIScreen.main.scale)])
        }
        
        titleLabel.text = post.title
        priceLabel.text = "\((post.price).formattedWithSeparator)đ"
        addressLabel.text = post.getFullAddress()
        authorLabel.text = "Đăng bởi \(post.userName)"
        if viewModel.isFavorite {
            heartImage.image = UIImage(systemName: "heart.fill")
            heartImage.tintColor = UIColor(named: ColorName.redStatusText)
        } else {
            heartImage.image = UIImage(systemName: "heart")
            heartImage.tintColor = UIColor(named: ColorName.gray)
        }
        
        if let userId = UserDefaults.userInfo?.id,
           userId == post.userId {
            heartImage.isHidden = true
        } else {
            heartImage.isHidden = false
        }
    }
    
    private func addPanGestureToDetailPopup() {
        let swipeDown = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        self.addGestureRecognizer(swipeDown)
    }
    
    @objc private func handleGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        gesture.location(in: self)
        switch gesture.state {
        case .began:
            print("began")
        case .changed:
            if translation.y > 0 {
                self.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended:
            if translation.y > 100 {
                UIView.animateKeyframes(withDuration: 0.4, delay: 0) {
                    self.transform = CGAffineTransform(translationX: 0, y: 220)
                } completion: { _ in
                    self.removeFromSuperview()
                    self.delegate?.deselectedAnnotationWhenDismissDetailPopup()
                }
            } else {
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 1) {
                    self.transform = .identity
                }
            }
            print("end")
        case .possible:
            print("possible")
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed")
        default:
            print("default")
        }
    }
    
    @IBAction func onClickedDetailButton(_ sender: UIButton) {
        delegate?.onClickedPostDetailButton(viewModel.post?.id ?? "")
    }
    
    func nibSetup() {
        let nibView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)!.first as! UIView
        nibView.frame = self.bounds
        addSubview(nibView)
    }
}

