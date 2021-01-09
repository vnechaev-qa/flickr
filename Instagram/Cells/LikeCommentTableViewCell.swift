//
//  LikeCommentTableViewCell.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 07.01.2021.
//

import UIKit

class LikeCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var likeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure() {
        likeImage.image = UIImage(named: "likePost")
    }
    
}
