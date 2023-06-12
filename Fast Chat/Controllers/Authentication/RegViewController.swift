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
    }
    
    @objc private func viewEndEdition(sender: UIGestureRecognizer) {
        self.view.endEditing(true)
        print("Gesture tapped")
    }
    
    override func loadView() {
        super.loadView()
        self.view = RegistrationView(frame: UIScreen.main.bounds)
    }
}

extension RegViewController: RegistrationViewProtocol {
    
    func goForward() {
        print("Registration view controller button tapped")
    }
}
