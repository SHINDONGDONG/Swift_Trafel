//
//  LoginViewController.swift
//  Swift_Trafel
//
//  Created by 申民鐡 on 2022/07/04.
//

import UIKit
import MBProgressHUD
import FirebaseAuth
import Loaf


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
    
    let authManager = AuthManager()
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
//    private let isSuccessfulLogin = true
    
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
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
    
//    private func showProgress() {
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//        hud.label.text = "Loading.."
//        hud.detailsLabel.text = "Detail"
//        hud.detailsLabel.textColor = .systemRed
//        hud.mode = .determinateHorizontalBar
//    }
    
    @IBAction func forgetPasswordButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Forget Password", message: "メールを入力してください。", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let okAlertAction = UIAlertAction(title: "OK", style: .default) { [ weak self ] _ in
            guard let this = self else { return }
            if let textfield = alertController.textFields?.first, let email = textfield.text, !email.isEmpty {
                this.authManager.resetPassword(withEmail: email) { result in
                    switch result {
                    case .failure(let error):
                        Loaf(error.localizedDescription, state: .error, location: .bottom, presentingDirection: .left, dismissingDirection: .left, sender: this).show(.short)
                    case .success:
                        this.showAlert(title: "メール送信成功", message: "パスワードの変更をお願いします。")
//                        Loaf("メール送信成功", state: .success, location: .bottom, presentingDirection: .left, dismissingDirection: .left, sender: this).show(.short)
                    }
                }
                
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive,handler: nil)
        alertController.addAction(okAlertAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlChange(_ sender: UISegmentedControl) {
        currentPageType = sender.selectedSegmentIndex == 0 ? .login : .signUp
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let passwordconfirmation = passwordConfirmationTextField.text, !passwordconfirmation.isEmpty
        else {
            showErrorMessage(text: "EmailやPasswordを入力してください。")
            return
        }
        guard password == passwordconfirmation else {
            showErrorMessage(text: "パスワードが一致していません。")
            return
        }
        
        guard password.count >= 6 else {
            showErrorMessage(text: "6桁以上にしてください。")
            return
        }
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
        authManager.signUpNewUser(whithEmail: email, password: password) { [weak self ] result in
            guard let this = self else { return }
            
            MBProgressHUD.hide(for: this.view, animated: true)
            switch result {
            case .success:
                this.delegate?.showMainTabBarController()
            case .failure(let erorr):
                this.showErrorMessage(text: erorr.localizedDescription)
                print("Email Error!!!!")
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            showErrorMessage(text: "Emailもしくはパスワードを入力してください。")
            return
        }
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Loading.."
        
        
        authManager.loginUser(withEmail: email, password: password) { [weak self] result in
            guard let this = self else { return }
            MBProgressHUD.hide(for: this.view, animated: true)
            switch result {
            case .failure(let error):
                this.showErrorMessage(text: error.localizedDescription)
            case .success:
                this.delegate?.showMainTabBarController()
            }
        }
    }
}

