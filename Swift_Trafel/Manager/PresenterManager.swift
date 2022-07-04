//
//  PresenterManager.swift
//  Swift_Trafel
//
//  Created by 申民鐡 on 2022/07/04.
//

import Foundation
import UIKit

class PresenterManager {
    
    static let shared = PresenterManager()
    private init (){}
    

    enum VC {
        case mainTabBarController
        case onboarding
    }
    
    func show(vc: VC) {
        
        var viewController: UIViewController
        
        switch vc {
        case .mainTabBarController:
            viewController = UIStoryboard(name: K.StoryboardId.main, bundle: nil).instantiateViewController(withIdentifier: K.StoryboardId.mainTabBarViewController)
        case .onboarding:
            viewController = UIStoryboard(name: K.StoryboardId.main, bundle: nil).instantiateViewController(withIdentifier: K.StoryboardId.onboardingViewController)
        }
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = viewController
            
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve,animations: nil, completion:  nil)
        }
        
        
    }
    
}
