//
//  PhotoModel.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 26.12.2020.
//

import Foundation
import SwiftyJSON

class PhotoModel: Equatable {
    static func == (lhs: PhotoModel, rhs: PhotoModel) -> Bool {
        lhs.id == rhs.id && lhs.owner == rhs.owner && lhs.secret == rhs.secret && lhs.server == rhs.server && lhs.farm == rhs.farm && lhs.title == rhs.title
    }
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    var title: String?
    
    var url: String?
    
    init(id: String, owner: String, secret: String, server: String, farm: Int, title: String?) {
        
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
    }
}

extension PhotoModel {
    convenience init(json: JSON) {
        let id = json["id"].stringValue
        let owner = json["owner"].stringValue
        let secret = json["secret"].stringValue
        let server = json["server"].stringValue
        let farm = json["farm"].intValue
        let title = json["title"].stringValue
        self.init(id: id, owner: owner, secret: secret, server: server, farm: farm, title: title)
    }
}
