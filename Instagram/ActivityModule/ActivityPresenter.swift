//
//  ActivityPresenter.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 28.12.2020.
//

import Foundation
protocol ActivityPresenterProtocol: class {
    func reloadData()
    var activities: [ActivityModel] { get }
    func activity(at indexPath: IndexPath) -> ActivityModel
}

class ActivityPresenter: ActivityPresenterProtocol {
    
    func activity(at indexPath: IndexPath) -> ActivityModel {
        return activities[indexPath.row]
    }
    
    func reloadData() {
        
    }

    weak var view: ActivityViewProtocol!
    
    var activities: [ActivityModel] = [ActivityModel(activity: "Понравилась ваша фотография"),
                                       ActivityModel(activity: "Понравилась ваша фотография"),
                                       ActivityModel(activity: "Понравилась ваша фотография"),
                                       ActivityModel(activity: "Оставил комментарий: Первонах "),
                                       ActivityModel(activity: "Понравилась ваша фотография"),
                                       ActivityModel(activity: "Понравилась ваша фотография"),
                                       ActivityModel(activity: "Понравилась ваша фотография"),
                                       ActivityModel(activity: "Понравилась ваша фотография"),
                                       ActivityModel(activity: "Понравилась ваша фотография")
                                       
    ]
    let lastActivities: [ActivityModel] = [
        ActivityModel(activity: "Вы можете знать этого человека"),
        ActivityModel(activity: "Подписался на вас"),
        ActivityModel(activity: "Отметил(а) вас на фото"),
        ActivityModel(activity: "Подписался на вас"),
        ActivityModel(activity: "Выложила(а) публикацию"),
    ]
}

extension ActivityViewController: ActivityViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
    
    
}
