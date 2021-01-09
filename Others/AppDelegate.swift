//
//  AppDelegate.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 26.12.2020.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let appAssembly = AppAssembly()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = UITabBarController()
        let tapeViewController = appAssembly.tapeViewController()
        let activityController = appAssembly.activityController()
        let profileViewController = appAssembly.profileController()
        let searchViewController = appAssembly.searchViewController()
        
        let tapeNavigationController = UINavigationController(rootViewController: tapeViewController)
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        let activitiNavigationCOntroller = UINavigationController(rootViewController: activityController)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)

        tabBarController.viewControllers = [tapeNavigationController, searchNavigationController, activitiNavigationCOntroller, profileNavigationController]
        
        
        window?.rootViewController = tabBarController

        return true
    }

}

