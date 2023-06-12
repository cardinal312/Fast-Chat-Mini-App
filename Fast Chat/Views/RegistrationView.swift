//
//  RegistrationView.swift
//  Fast Chat
//
//  Created by Macbook on 10/6/23.
//

import UIKit

protocol RegistrationViewProtocol: AnyObject {
    func goForward()
    func moveToLogVC()
}

final class RegistrationView: UIView {
    
    weak var delegate: RegistrationViewProtocol?
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Bradley Hand", size: 30)
        label.textAlignment = .center
        label.text = "РЕГИСТРАЦИЯ"
        label.textColor = .white
        return label
    }()
    
    
    private lazy var emailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textColor = .systemRed
        textfield.textAlignment = .left
        textfield.attributedPlaceholder = NSAttributedString(string: "Email:", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textfield
    }()
    
    
    private lazy var passwordView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var passwordView1TextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textColor = .systemRed
        textfield.isSecureTextEntry = true
        textfield.textAlignment = .left
        textfield.attributedPlaceholder = NSAttributedString(string: "пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textfield
    }()
    
    
    private lazy var passwordView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    
    private lazy var passwordView2TextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textColor = .systemRed
        textfield.isSecureTextEntry = true
        textfield.textAlignment = .left
        textfield.attributedPlaceholder = NSAttributedString(string: "повторить пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
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
    
    private lazy var haveAccountbutton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("есть аккаунд?", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont(name: "Bonodi Ornaments", size: 7)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(goToLoginVC), for: .touchUpInside)
        return button
    }()
    
    //MARK: - INIT FRAME
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setup()
        
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
        
        self.passwordView1.layer.borderWidth = 1
        self.passwordView1.layer.cornerRadius = 24
        
        self.passwordView2.layer.borderWidth = 1
        self.passwordView2.layer.cornerRadius = 24
        
        }
    
    @objc private func goToLoginVC() {
        print("Est accound button tapped")
        self.delegate?.moveToLogVC()
    }
    
    
    @objc private func goToForvard() {
        self.delegate?.goForward()
    }
    
    
    // MARK: - CONSTRAINTS
    
    private func setup() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
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
        
        self.addSubview(passwordView1)
        NSLayoutConstraint.activate([
            self.passwordView1.topAnchor.constraint(equalTo: self.emailView.bottomAnchor, constant: 40),
            self.passwordView1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.passwordView1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.passwordView1.widthAnchor.constraint(equalToConstant: 280),
            self.passwordView1.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.passwordView1.addSubview(passwordView1TextField)
        NSLayoutConstraint.activate([
            self.passwordView1TextField.topAnchor.constraint(equalTo: self.passwordView1.topAnchor, constant: 5),
            self.passwordView1TextField.leadingAnchor.constraint(equalTo: self.passwordView1.leadingAnchor, constant: 20),
            self.passwordView1TextField.trailingAnchor.constraint(equalTo: self.passwordView1.trailingAnchor, constant: -10),
            self.passwordView1TextField.bottomAnchor.constraint(equalTo: self.passwordView1.bottomAnchor, constant: -5)
        ])
        
        self.addSubview(passwordView2)
        NSLayoutConstraint.activate([
            self.passwordView2.topAnchor.constraint(equalTo: self.passwordView1.bottomAnchor, constant: 30),
            self.passwordView2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.passwordView2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.passwordView2.widthAnchor.constraint(equalToConstant: 280),
            self.passwordView2.heightAnchor.constraint(equalToConstant: 50)])
        
        
        self.passwordView2.addSubview(passwordView2TextField)
        NSLayoutConstraint.activate([
            self.passwordView2TextField.topAnchor.constraint(equalTo: self.passwordView2.topAnchor, constant: 5),
            self.passwordView2TextField.leadingAnchor.constraint(equalTo: self.passwordView2.leadingAnchor, constant: 20),
            self.passwordView2TextField.trailingAnchor.constraint(equalTo: self.passwordView2.trailingAnchor, constant: -10),
            self.passwordView2TextField.bottomAnchor.constraint(equalTo: self.passwordView2.bottomAnchor, constant: -5)
        ])
        
        self.addSubview(button)
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: self.passwordView2.bottomAnchor, constant: 70),
            self.button.leadingAnchor.constraint(equalTo: self.passwordView2.leadingAnchor, constant: 60),
            self.button.trailingAnchor.constraint(equalTo: self.passwordView2.trailingAnchor, constant: -60),
            self.button.heightAnchor.constraint(equalToConstant: 40),
            self.button.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        self.addSubview(haveAccountbutton)
        NSLayoutConstraint.activate([
            self.haveAccountbutton.topAnchor.constraint(equalTo: self.passwordView2.bottomAnchor, constant: 10),
            self.haveAccountbutton.leadingAnchor.constraint(equalTo: self.passwordView2.leadingAnchor, constant: 10),
            //self.NoAccountbutton.trailingAnchor.constraint(equalTo: self.passwordView2.trailingAnchor, constant: -60),
            self.haveAccountbutton.heightAnchor.constraint(equalToConstant: 30),
            self.haveAccountbutton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        
    }
}
