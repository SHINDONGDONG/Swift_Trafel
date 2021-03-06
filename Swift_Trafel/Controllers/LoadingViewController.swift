//
//  LoadingViewController.swift
//  Swift_Trafel
//
//  Created by 申民鐡 on 2022/07/04.
//

import UIKit
import FirebaseAuth


class LoadingViewController: UIViewController {
    // MARK: - Properties
//    private var isUserLoggedIn: Bool {
//        return Auth.auth().currentUser != nil
//    }
    
    let authManager = AuthManager()
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delay(durationInSeconds: 2) {
            self.showInitailView()
        }
    }
    

    // MARK: - Configures
    private func configures(){
    }
    
    
    private func showInitailView(){
        if authManager.isUserLoggedIn() {
            PresenterManager.shared.show(vc: .mainTabBarController)
        }else {
            performSegue(withIdentifier: K.Segue.showOnboarding, sender: nil)
        }
    }

}
