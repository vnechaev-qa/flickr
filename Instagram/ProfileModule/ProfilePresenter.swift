//
//  ProfilePresenter.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 27.12.2020.
//
import SwiftyJSON
import Foundation

protocol ProfilePresenterProtocol: class {
    var profile: ProfileModel { get }
    func numberOfPhotos() -> Int
    func photo(at indexPath: IndexPath) -> PhotoModel?
    func loadData() -> Void
    func reloadData()
    
}

class ProfilePresenter: ProfilePresenterProtocol {
    func numberOfPhotos() -> Int {
        return dataSource.count
    }
    
    func photo(at indexPath: IndexPath) -> PhotoModel? {
        return dataSource[indexPath.row]
    }
    
    func loadData() {
        loadPhotos()
    }
    
    func reloadData() {
        loadPhotos()
    }
    
    weak var view: ProfileViewProtocol!
    
    private let urlCreaterService = UrlCreaterService()
    var dataSource: [PhotoModel] = []
    let page = 1
    var per_page = 10
    var profile: ProfileModel = ProfileModel(postLabel: "666", folowersLabel: "14", folowingLabel: "88", descriptionLabel: "Ivan Ivanov. Hello everyone!")
    
    func loadPhotos() {
        Api_wrapper.getInteresPhoto(page: page,
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
