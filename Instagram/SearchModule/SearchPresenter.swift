//
//  SearchPresenter.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 07.01.2021.
//
import SwiftyJSON
import Foundation

protocol SearchPresenterProtocol: class {
    func numberOfPhotos() -> Int
    func photo(at indexPath: IndexPath) -> PhotoModel?
    func loadData() -> Void
}

class SearchPresenter: SearchPresenterProtocol {
    
    weak var view: SearchViewProtocol! // inject
    let page = 1
    var per_page = 45
    var searchText = ""
    private let urlCreaterService = UrlCreaterService()
    var dataSource: [PhotoModel] = []
    var photos: PhotoModel!
    
    func numberOfPhotos() -> Int {
        return dataSource.count
    }
    
    func photo(at indexPath: IndexPath) -> PhotoModel? {
        return dataSource[indexPath.row]
    }
    
    func loadData() {
        loadPhotos()
    }
    
//    func searchPhoto() {
//        loadData() { [weak self] photos in
//            guard let strongSelf = self else { return }
//            if let photos = photos {
//                strongSelf.photos
//                strongSelf.view.reloadData()
//            }
//        }
//    }
    
    func loadPhotos() {
        Api_wrapper.searchPhoto(searchText: searchText,
                                page: page,
                                per_page: per_page) { [weak self] (response) in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                let json = JSON(response)
                let jsonPhotosArray = json["photos"]["photo"].arrayValue
                
                var photos: [PhotoModel] = []
                
                for jsonPhoto in jsonPhotosArray {
                    let id = jsonPhoto["id"].stringValue
                    let owner = jsonPhoto["owner"].stringValue
                    let secret = jsonPhoto["secret"].stringValue
                    let server = jsonPhoto["server"].stringValue
                    let farm = jsonPhoto["farm"].intValue
                    let title = jsonPhoto["title"].stringValue
                    
                    let model = PhotoModel(id: id, owner: owner, secret: secret, server: server, farm: farm, title: title)
                    
                    let url = self.urlCreaterService.createUrl(withModel: model)
                    model.url = url
                    
                    if photos.contains(model) {
                        print("фото уже есть")
                    } else {
                        photos.append(model)
                    }
                    
                    self.per_page = self.per_page + 10
                    
                    self.dataSource = photos
                    self.view.reloadData()
                }
            }
        } failure: { (error) in
            print(error)
        }
    }
}
