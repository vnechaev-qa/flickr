//
//  UrlCreateService.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 26.12.2020.
//

import Foundation

class UrlCreaterService {
    func createUrl(withModel model: PhotoModel)-> String {
        let url = "https://farm\(model.farm).staticflickr.com/\(model.server)/\(model.id)_\(model.secret)_m.jpg"
        print(url)
        return url
    }
}
