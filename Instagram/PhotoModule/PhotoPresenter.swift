//
//  PhotoPresenter.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 31.12.2020.
//

import Foundation

protocol PhotoPresenterProtocol: class {
    func commentMode(at indexPath: IndexPath) -> CommentModel
    func reloadData()
    var comments: [CommentModel] { get }
}

class PhotoPresenter: PhotoPresenterProtocol {
    func commentMode(at indexPath: IndexPath) -> CommentModel {
        return comments[indexPath.row]
    }
    
    func reloadData() {
        
    }
    
    weak var view: PhotoViewProtocol!
    var comments: [CommentModel] = [CommentModel(name: "akonoplev", comment: "Где твой NavigationController???, дизлайк!"),
                                    CommentModel(name: "denissss", comment: "как тут оставлять комментарии?"),
                                    CommentModel(name: "vnechaev", comment: "лайки не жмуться, приложение говно"),
                                    CommentModel(name: "Валерий Сюткин", comment: "ББПЕ"),
                                    CommentModel(name: "user1", comment: "классека"),
    ]
}

extension PhotoViewController: PhotoViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}
