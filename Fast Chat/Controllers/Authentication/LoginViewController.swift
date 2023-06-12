//
//  LoginViewController.swift
//  Fast Chat
//
//  Created by Macbook on 10/6/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var regView: LoginView { return self.view as! LoginView }
    private let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login View Controller"
        //view.backgroundColor = .systemIndigo
        
        viewTapGesture.addTarget(self, action: #selector(viewEndEdition(sender:)))
        view.addGestureRecognizer(viewTapGesture)
        
        self.regView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .remove, style: .plain, target: self, action: #selector(goToStartVC))
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
        navigationController?.pushViewController(MainTabBarController(), animated: true)
    }
    
    
}
