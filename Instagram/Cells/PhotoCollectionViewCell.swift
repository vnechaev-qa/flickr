//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 26.12.2020.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    func configure(with model: PhotoModel) {
        
        if let imageURL = model.url, let url = URL(string: imageURL) {
            imageView.kf.setImage(with: url)
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
    }
}





