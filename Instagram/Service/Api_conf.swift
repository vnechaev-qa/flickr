//
//  Api_conf.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 26.12.2020.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

class Api_conf {
    
    //Создаем запрос в интернет чтобы получить какие то данные от сервера.
    class func createRequest(url: String, method: HTTPMethod, params: [String: AnyHashable]) -> URLRequest {
        
        var url = url + "?"
        
        for (key, value) in params {
            url += key + "=" + "\(value)" + "&"
        }
        
        //www.flickr.com?page=1&offser=15&lang=en
        url = String(url.dropLast())
        //www.flickr.com?page=1&offser=15&lang=en&
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = method.rawValue
        return request
    }
    
    //Обрабатываем то что пришло по запросу
    class func generalCompletionHandler(data: Data?,
                                        error: Error?,
                                        success: (_ json: Any) -> Void,
                                        failure: (_ error: String?) -> Void) {
    
        if let error = error { //Проверяем пришла ли ошибка с сервера
            failure(error.localizedDescription)
        }
        
        guard let data = data else { //Проверяем вернулась ли какая то дата, если нет то выбрасываем ошибку
            failure("Data is nil!")
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) //Пытаемся сериализовать данные в JSON, если не удалось выполнится блок catch
            success(json)
        } catch(let error) {
            failure("Не удалось сериализовать дату в json \(error)")
            return
        }
    }
}
