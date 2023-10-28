//
//  CustomCollectionViewCell.swift
//  Fast Chat
//
//  Created by Macbook on 10/6/23.
//

import UIKit

protocol CustomCollectionViewCellProtocol: AnyObject {
    func moveToRegVC()
    func moveToLoginVC()
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let customID = "customID"
    weak var delegate: CustomCollectionViewCellProtocol?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Optima", size: 25)
        label.textAlignment = .center
        label.text = "MINI MASSANGER"
        label.textColor = .white
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.layer.cornerRadius = 12
        button.setTitle("Зарегистрироваться", for: .normal)
        button.titleLabel?.font = UIFont(name: "Optima", size: 18)
        button.addTarget(self, action: #selector(goToRegVc), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont(name: "Optima", size: 16)
        button.addTarget(self, action: #selector(goToLogVc), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomPageControl: UIPageControl = {
        let pc = UIPageControl(frame: .zero)
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = 3
        pc.backgroundColor = .none
        pc.currentPageIndicatorTintColor = UIColor.red
        pc.isSelected = true
        pc.backgroundStyle = .prominent
        pc.isUserInteractionEnabled = true
        return pc
    }()
    
    @objc private func goToRegVc() {
        self.delegate?.moveToRegVC()
    }
    
    @objc private func goToLogVc() {
        self.delegate?.moveToLoginVC()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.layer.borderWidth = 3
        button.backgroundColor = UIColor.systemBlue
        button.layer.shadowColor = UIColor.systemOrange.cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 10
    }
    
    public func setImage(images: Slides) {
        self.imageView.image = images.image
        self.bottomPageControl.currentPage = images.id
        
        if images.id == 2 {
            self.button.layer.borderColor = UIColor.systemOrange.cgColor
            self.titleLabel.textColor = .systemRed
            self.button.isHidden = false
            self.clearButton.isHidden = false
            self.bottomPageControl.isHidden = true
        }
        
    }
    
    
    private func setupConstraints() {
        self.contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
        self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
        self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
        self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        self.imageView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.topAnchor, constant: 150),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor, constant: 80),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: -80),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.contentView.addSubview(button)
        NSLayoutConstraint.activate([
            self.button.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -100),
            self.button.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor),
            self.button.widthAnchor.constraint(equalToConstant: 300),
            self.button.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.contentView.addSubview(clearButton)
        NSLayoutConstraint.activate([
            self.clearButton.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -50),
            self.clearButton.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor, constant: 100),
            self.clearButton.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: -100),
            self.clearButton.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor),
            self.clearButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        self.contentView.addSubview(bottomPageControl)
        NSLayoutConstraint.activate([
            self.bottomPageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            self.bottomPageControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            self.bottomPageControl.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -100)
        ])
        
    }
    
}
