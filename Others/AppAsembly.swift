//
//  AppAsembly.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 27.12.2020.
//
import UIKit
import Foundation

class AppAssembly {
    func tapeViewController() -> TapeViewController {
        let viewController = TapeViewController.create()
        let presenter = TapePresenter()
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }
    
    func profileController() -> ProfileViewController {
        let viewController = ProfileViewController.create()
        let presenter = ProfilePresenter()
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }
    
    func activityController() -> ActivityViewController {
        let viewcontroller = ActivityViewController.create()
        let presenter = ActivityPresenter()
        presenter.view = viewcontroller
        viewcontroller.presenter = presenter
        return viewcontroller
    }
    
    func detailedViewController(photo: PhotoModel) -> UIViewController {
        let vc = PhotoViewController.create()
        let presenter = PhotoPresenter()
        vc.presenter = presenter
        presenter.view = vc
        vc.photo = photo
        return vc
    }
    
    func searchViewController() -> SearchViewController {
        let vc = SearchViewController.create()
        let presenter = SearchPresenter()
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
}
