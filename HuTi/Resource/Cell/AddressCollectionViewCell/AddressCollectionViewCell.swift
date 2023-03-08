//
//  AddressCollectionViewCell.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import UIKit

class AddressCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var view: UIView!
    private let cellView = UIView()
    
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
        cellView.backgroundColor = UIColor(named: "white")
        cellView.layer.cornerRadius = 10
        view.alpha = 0
        addSubview(cellView)
        
        cellView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [cellView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10),
                           cellView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -10),
                           cellView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
                           cellView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)]
        NSLayoutConstraint.activate(constraints)
        sendSubviewToBack(cellView)
        bringSubviewToFront(titleLabel)
    }
}
