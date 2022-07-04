//
//  SettingsViewController.swift
//  Swift_Trafel
//
//  Created by 申民鐡 on 2022/07/04.
//

import UIKit

class SettingsViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configures()
    }
    

    // MARK: - Configures
    private func configures(){
    }

    @IBAction func logoutBtnTapped(_ sender: UIBarButtonItem) {
        PresenterManager.shared.show(vc: .onboarding)
        
    }
}
