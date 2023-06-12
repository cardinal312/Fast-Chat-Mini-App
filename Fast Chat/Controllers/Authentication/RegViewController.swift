//
//  RegViewController.swift
//  Fast Chat
//
//  Created by Macbook on 10/6/23.
//

import UIKit

class RegViewController: UIViewController {
    
    private var regView: RegistrationView { return self.view as! RegistrationView }
    private let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    //MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regView.delegate = self
        
        viewTapGesture.addTarget(self, action: #selector(viewEndEdition(sender:)))
        view.addGestureRecognizer(viewTapGesture)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .remove, style: .plain, target: self, action: #selector(goToStartVC))
        
        
       // self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style: .done, target:nil, action:nil)
    
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
        print("Registration view controller button tapped")
    }
}
