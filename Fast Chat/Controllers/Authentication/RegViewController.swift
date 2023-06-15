//
//  RegViewController.swift
//  Fast Chat
//
//  Created by Macbook on 10/6/23.
//

import UIKit
import FirebaseAuth

class RegViewController: UIViewController {
    
    private var regView: RegistrationView { return self.view as! RegistrationView }
    private var checkField = CheckField.shared
    private var service = NetworkService.shared
    
    private let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    //MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regView.delegate = self
        
        viewTapGesture.addTarget(self, action: #selector(viewEndEdition(sender:)))
        view.addGestureRecognizer(viewTapGesture)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .remove, style: .plain, target: self, action: #selector(goToStartVC))
        
        
        // self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style: .done, target:nil, action:nil)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    
    @objc private func viewEndEdition(sender: UIGestureRecognizer) {
        self.view.endEditing(true)
        print("Gesture tapped")
    }
    
    @objc private func goToStartVC() {
        navigationController?.pushViewController(StartViewController(), animated: true)
    }
    
    override func loadView() {
        super.loadView()
        self.view = RegistrationView(frame: UIScreen.main.bounds)
    }
}

extension RegViewController: RegistrationViewProtocol {
    
    
    func moveToLogVC() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    
    func goForward() {

        if checkField.validField(regView.emailView, regView.emailTextField),
           checkField.validField(regView.passwordView1, regView.passwordView1TextField) {
            
            if regView.passwordView1TextField.text == regView.passwordView2TextField.text {
                print("Good job! Passwords is iqualls! 😀")
                
                service.createNewUser(LoginField(email: regView.emailTextField.text!, password: regView.passwordView1TextField.text!)) { [weak self] responseCode in
                    
                    switch responseCode.code {
                    case 0:
                        print("Firebase: db error")
                    case 1:
                        print("Firebase: Gooood response")
                        self?.service.confirmEmail()
                        
                        
                        
                        let alert = UIAlertController(title: "Congratulations 🎉🎉🎉", message: "You successfully log in! We are sent message to your email adress: \(self!.regView.emailTextField.text ?? "nil"), please confirm this into 30 days", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel)
                        alert.addAction(action)
                        self?.present(alert, animated: true)
                        
                        //navigation root vc
                    default:
                        print("Unknowned error, may be in self code")
                    }
                }
                
            } else {
                print("Passwords is not iqualls, please try again! ")
            }
        }
    }
}
