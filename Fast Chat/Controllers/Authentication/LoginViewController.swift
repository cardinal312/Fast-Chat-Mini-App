//
//  LoginViewController.swift
//  Fast Chat
//
//  Created by Macbook on 10/6/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var userDefaults = UserDefaults.standard
    private var logView: LoginView { return self.view as! LoginView }
    private var checkField = CheckField.shared
    private var service = NetworkService.shared
    
    private let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewTapGesture.addTarget(self, action: #selector(viewEndEdition(sender:)))
        view.addGestureRecognizer(viewTapGesture)
        
        self.logView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .remove, style: .plain, target: self, action: #selector(goToStartVC))
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @objc private func goToStartVC() {
        navigationController?.pushViewController(StartViewController(), animated: true)
    }
    
    
    @objc private func viewEndEdition(sender: UIGestureRecognizer) {
        self.view.endEditing(true)
        print("Gesture tapped")
    }
    
    override func loadView() {
        super.loadView()
        self.view = LoginView(frame: UIScreen.main.bounds)
    }
    
}


extension LoginViewController: LoginViewDelegate {
    
    func moveToReggVC() {
        navigationController?.pushViewController(RegViewController(), animated: true)
    }
    
    func goToTabbar() {
        print("Login view controller delegate tapped")
        
        if checkField.validField(logView.emailView, logView.emailTextField),
           checkField.validField(logView.passwordView, logView.passwordViewTextField) {
            
            service.authInApp(LoginField(email: logView.emailTextField.text!, password: logView.passwordViewTextField.text!)) { [weak self] response in
                
                switch response {
                    
                case .success:
                    print("next next next")
                    
                    self?.userDefaults.set(true, forKey: "isLogin") //MARK: USER DEFAULTS
                    if ((self?.userDefaults.object(forKey: "isLogin")) != nil) {
                        self?.navigationController?.pushViewController(MainTabBarController(), animated: true)
                    }
                case .noVerify:
                    let alert = self?.alertCreate("Error", "You are not verify your email, to your inbox sent link of registration")
                    let action = UIAlertAction(title: "OK", style: .cancel)
                    alert?.addAction(action)
                    self?.present(alert!, animated: true)
                case .error:
                    let alert = self?.alertCreate("Error", "Email or password still not iquals")
                    let action = UIAlertAction(title: "OK", style: .cancel)
                    alert?.addAction(action)
                    self?.present(alert!, animated: true)
                    
                }
            }
        }
        else {
            let alert = self.alertCreate("Error", "Please try check your written data again")
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    func alertCreate(_ title: String, _ message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        return alert
    }
    
    
    
    
}
