//
//  PhotoViewController.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 31.12.2020.
//
import UIKit
import Foundation


protocol PhotoViewProtocol: class {
    func reloadData()
}

class PhotoViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var photoProfile: UIImageView! 
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            registerNib()
        }
    }
    var presenter: PhotoPresenterProtocol!
    var photo: PhotoModel!
    private let urlCreaterService = UrlCreaterService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let photo = photo else { return }
        let url = urlCreaterService.createUrl(withModel: photo)
        photoProfile.kf.setImage(with: URL(string: url))
    }
}

extension PhotoViewController: UIWebViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let likeCell = tableView.dequeueReusableCell(withIdentifier: "likeCell", for: indexPath) as! LikeCommentTableViewCell
            likeCell.configure()
            return likeCell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
            let model = presenter.commentMode(at: indexPath)
            cell.configurate(with: model)
            return cell
        }
    }
}

extension PhotoViewController: Storyboardeable {
    static func storyboardName() -> String {
        return "Detailed"
    }
}

extension PhotoViewController {
    fileprivate func registerNib() {
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CommentCell")
        
        let nib2 = UINib(nibName: "LikeCommentTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "likeCell")
   
    }
}
