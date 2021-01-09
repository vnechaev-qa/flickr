//
//  ProfileTableViewCell.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 27.12.2020.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var folowingLabel: UILabel!
    @IBOutlet weak var folowersLabel: UILabel!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var avatar_icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func confirutate(with model: ProfileModel) {
        descriptionLabel.text = model.descriptionLabel
        folowingLabel.text = model.folowingLabel
        folowersLabel.text = model.folowersLabel
        postsLabel.text = model.postLabel
        avatar_icon.image = UIImage(named: "avatar")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
