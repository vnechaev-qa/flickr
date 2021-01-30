//
//  Api_wrapper.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 26.12.2020.
//

import Foundation

class Api_wrapper {
    class func getInteresPhoto(page: Int,
                               per_page: Int,
                               success: @escaping (_ json: Any) -> Void,
                               failure: @escaping (_ error: String?) -> Void) {
        
        let url = Constants.API_const.baseUrl
        
        var params: [String: AnyHashable] = [
            "method": "flickr.interestingness.getList",
            "api_key": Constants.API_const.token,
            "format": "json",
            "per_page": per_page,
            "page": page,
            "nojsoncallback": 1
        ]
        
        
        let method: HTTPMethod = .GET
        
        let request: URLRequest = Api_conf.createRequest(url: url,
                                                         method: method,
                                                         params: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            Api_conf.generalCompletionHandler(data: data, error: error, success: success, failure: failure)
        }
        
        dataTask.resume()
        
    }
    
    class func searchPhoto(searchText: String,
                           page: Int,
                           per_page: Int,
                           success: @escaping (_ json: Any) -> Void,
                           failure: @escaping (_ error: String?) -> Void) {
        
        let url = Constants.API_const.baseUrl
        
        let params: [String: AnyHashable] = [
            "method": "flickr.photos.search",
            "api_key": Constants.API_const.token,
            "format": "json",
            "nojsoncallback": 1,
            "per_page": per_page,
            "page": page,
            "text": searchText
        ]
        
        let method: HTTPMethod = .GET
        let request: URLRequest = Api_conf.createRequest(url: url,
                                                         method: method,
                                                         params: params)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            Api_conf.generalCompletionHandler(data: data, error: error, success: success, failure: failure)
        }
        
        dataTask.resume()
        
    }
    
    class func getSizeForPhoto(photoID: String,
                               success: @escaping (_ json: Any) -> Void,
                               failure: @escaping () -> Void) {
        
    }
}
