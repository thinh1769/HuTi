//
//  ProjectFilterResultTableViewCell.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 21/03/2023.
//

import UIKit

class ProjectFilterResultTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var investorLabel: UILabel!
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        thumbnail.image = nil
        self.selectionStyle = .none
        cellView.layer.cornerRadius = 10
    }
    
    func config(project: Project) {
        name.text = project.name
        addressLabel.text = "\(project.wardName), \(project.districtName), \(project.provinceName)"
        statusLabel.text = project.status
        self.configStatusView(project.status)
        investorLabel.text = project.investor
    }
    
    func loadThumbnail(thumbnail: UIImage) {
        self.thumbnail.image = thumbnail
    }
    
    private func configStatusView(_ status: String) {
        switch status {
        case PickerData.status[0]:
            statusView.backgroundColor = UIColor(named: ColorName.redStatusBackground)
            statusLabel.textColor = UIColor(named: ColorName.redStatusText)
        case PickerData.status[1]:
            statusView.backgroundColor = UIColor(named: ColorName.greenStatusBackground)
            statusLabel.textColor = UIColor(named: ColorName.greenStatusText)
        case PickerData.status[2]:
            statusView.backgroundColor = UIColor(named: ColorName.purpleStatusBackground)
            statusLabel.textColor = UIColor(named: ColorName.purpleStatusText)
        default:
            return
        }
    }
    
}
