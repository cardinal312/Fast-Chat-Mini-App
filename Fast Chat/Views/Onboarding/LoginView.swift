//
//  LoginView.swift
//  Fast Chat
//
//  Created by Macbook on 12/6/23.
//

import Foundation
import UIKit

protocol LoginViewDelegate: AnyObject {
    func moveToReggVC()
    func goToTabbar()
}

class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Bradley Hand", size: 27)
        label.textAlignment = .center
        label.text = "ДОБРО ПОЖАЛОВАТЬ"
        label.textColor = .white
        return label
    }()
    
    
     lazy var emailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
     lazy var emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textColor = .black
        textfield.textAlignment = .left
        textfield.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textfield.restorationIdentifier = "email"
        return textfield
    }()
    
    
     lazy var passwordView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
     lazy var passwordViewTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textColor = .black
        textfield.isSecureTextEntry = true
        textfield.textAlignment = .left
        textfield.attributedPlaceholder = NSAttributedString(string: "пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textfield.restorationIdentifier = "password"
        return textfield
    }()
    
    
   
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ПОДТВЕРДИТЬ", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont(name: "Bonodi Ornaments", size: 18)
        button.addTarget(self, action: #selector(goToForvard), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var noAccountbutton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("нет аккаунда?", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont(name: "Bonodi Ornaments", size: 7)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(goToRegistrVC), for: .touchUpInside)
        return button
    }()
    

    @objc private func goToRegistrVC() {
        self.delegate?.moveToReggVC()
    }
    
    @objc private func goToForvard() {
        self.delegate?.goToTabbar()
    }
    
    
    
    //MARK: - INIT FRAME

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
override func layoutSubviews() {
    
    self.button.layer.cornerRadius = 12
    self.button.layer.borderWidth = 1
    
    self.emailView.layer.cornerRadius = 24
    self.emailView.layer.borderWidth = 1
    self.emailView.layer.borderColor = UIColor.white.cgColor
    
    self.passwordView.layer.borderWidth = 1
    self.passwordView.layer.cornerRadius = 24

    }
    
    // MARK: - CONSTRAINTS
    
    private func configure() {
        
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 80),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            self.titleLabel.widthAnchor.constraint(equalToConstant: 280),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.addSubview(emailView)
        NSLayoutConstraint.activate([
            self.emailView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 40),
            self.emailView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.emailView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.emailView.widthAnchor.constraint(equalToConstant: 280),
            self.emailView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.emailView.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            self.emailTextField.topAnchor.constraint(equalTo: self.emailView.topAnchor, constant: 5),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.emailView.leadingAnchor, constant: 20),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.emailView.trailingAnchor, constant: -10),
            self.emailTextField.bottomAnchor.constraint(equalTo: self.emailView.bottomAnchor, constant: -5)
        ])
        
        self.addSubview(passwordView)
        NSLayoutConstraint.activate([
            self.passwordView.topAnchor.constraint(equalTo: self.emailView.bottomAnchor, constant: 40),
            self.passwordView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.passwordView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.passwordView.widthAnchor.constraint(equalToConstant: 280),
            self.passwordView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.passwordView.addSubview(passwordViewTextField)
        NSLayoutConstraint.activate([
            self.passwordViewTextField.topAnchor.constraint(equalTo: self.passwordView.topAnchor, constant: 5),
            self.passwordViewTextField.leadingAnchor.constraint(equalTo: self.passwordView.leadingAnchor, constant: 20),
            self.passwordViewTextField.trailingAnchor.constraint(equalTo: self.passwordView.trailingAnchor, constant: -10),
            self.passwordViewTextField.bottomAnchor.constraint(equalTo: self.passwordView.bottomAnchor, constant: -5)
        ])
        
        
        self.addSubview(button)
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: self.passwordView.bottomAnchor, constant: 60),
            self.button.leadingAnchor.constraint(equalTo: self.passwordView.leadingAnchor, constant: 60),
            self.button.trailingAnchor.constraint(equalTo: self.passwordView.trailingAnchor, constant: -60),
            self.button.heightAnchor.constraint(equalToConstant: 40),
            self.button.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        self.addSubview(noAccountbutton)
        NSLayoutConstraint.activate([
            self.noAccountbutton.topAnchor.constraint(equalTo: self.passwordView.bottomAnchor, constant: 10),
            self.noAccountbutton.leadingAnchor.constraint(equalTo: self.passwordView.leadingAnchor, constant: 10),
            //self.NoAccountbutton.trailingAnchor.constraint(equalTo: self.passwordView2.trailingAnchor, constant: -60),
            self.noAccountbutton.heightAnchor.constraint(equalToConstant: 30),
            self.noAccountbutton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
    }
    
    
}
