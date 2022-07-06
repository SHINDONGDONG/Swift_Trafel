//
//  SettingsViewController.swift
//  Swift_Trafel
//
//  Created by 申民鐡 on 2022/07/04.
//

import UIKit
import MBProgressHUD
import FirebaseAuth
import Loaf


class SettingsViewController: UIViewController {
    // MARK: - Properties
    let authManager = AuthManager()
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configures()
    }
    

    // MARK: - Configures
    private func configures(){
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        title = K.NavigationTtile.settings
    }

    @IBAction func logoutBtnTapped(_ sender: UIBarButtonItem) {
        MBProgressHUD.showAdded(to: view, animated: true)
        delay(durationInSeconds: 0.5) { [weak self] in
            
            guard let this = self else { return }
            let result = this.authManager.logoutUser()
            switch result {
            case .failure(let error):
                Loaf(error.localizedDescription, state: .error, location: .bottom, sender: this).show()
                
            case .success:
                Loaf("로그아웃 성공!", state: .success, location: .top, sender: this).show()
                delay(durationInSeconds: 1) {
                    PresenterManager.shared.show(vc: .onboarding)
                }
            }
            MBProgressHUD.hide(for: this.view, animated: true)
            
//            do {
//                try Auth.auth().signOut()
//                PresenterManager.shared.show(vc: .onboarding)
//            } catch {
//                print(error.localizedDescription)
//                MBProgressHUD.hide(for: self.view, animated: true)
//            }
        }
        
    }
}
