//
//  LoginViewController.swift
//  Swift_Trafel
//
//  Created by 申民鐡 on 2022/07/04.
//

import UIKit
import MBProgressHUD


class LoginViewController: UIViewController {

    // MARK: - Properties
    private var errorMessage: String? {
        didSet {
            showErrorMessage(text: errorMessage)
        }
    }
    
    //画面のLabel ,Button,Controller
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    weak var delegate :OnboardingViewControllerDelegate?
    
    //segment pageType
    private enum pageType{
        case login
        case signUp
    }
    
    
    private var currentPageType: pageType = .login {
        didSet {
            setupViewFor(pagetype: currentPageType)
        }
    }
    
    //Loginが成功したらTrueを返す
    private let isSuccessfulLogin = false
    
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configures()
    }
    

    // MARK: - Configures
    private func configures() {
        setupViewFor(pagetype: .login)
    }
    
    private func setupViewFor(pagetype: pageType) {
        errorLabel.text = nil
        signUpButton.isHidden = pagetype == .login
        passwordConfirmationTextField.isHidden = pagetype == .login
        loginButton.isHidden = pagetype == .signUp
        forgetPasswordButton.isHidden = pagetype == .signUp
    }
    
    private func showErrorMessage(text: String?) {
        errorLabel.isHidden = text == nil
        errorLabel.text = text
    }
    
    
    @IBAction func forgetPasswordButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func segmentedControlChange(_ sender: UISegmentedControl) {
        currentPageType = sender.selectedSegmentIndex == 0 ? .login : .signUp
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        if isSuccessfulLogin {
            delegate?.showMainTabBarController()
        } else {
            errorMessage = "IDもしくはPasswordをご確認ください。"
        }
        
        
    }
    
}
