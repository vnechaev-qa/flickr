//
//  ActivityTableViewCell.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 26.12.2020.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    func configurate(with model: ActivityModel) {
        activityLabel.text = model.activity
        avatar.image = model.avatar
    }
    
    fileprivate func setupLayout() {
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 25
        activityLabel.font = .systemFont(ofSize: 10, weight: .medium)
    }
}
