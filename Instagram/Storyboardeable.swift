//
//  Storyboardeable.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 27.12.2020.
//

import UIKit
import Foundation

protocol Storyboardeable {
    static func storyboardName() -> String
    
}
extension Storyboardeable where Self: UIViewController {
    
    static func create() -> Self {
        let storyboard = self.storyboard()
        
        let className = NSStringFromClass(Self.self)
        let finalClassName = className.components(separatedBy: ".").last!
        let viewControllerId = finalClassName + "ID"
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId)
        return viewController as! Self
        
    }
    
    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: storyboardName(), bundle: nil)
    }
    
}
