//
//  CommentTableViewCell.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 31.12.2020.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    func configurate(with model: CommentModel) {
        nameLabel.text = model.name
        commentLabel.text = model.comment
    }
    
    fileprivate func setupLayout() {
        nameLabel.font = .boldSystemFont(ofSize: 9)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
