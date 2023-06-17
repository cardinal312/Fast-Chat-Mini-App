//
//  UsersTableViewCell.swift
//  Fast Chat
//
//  Created by Macbook on 15/6/23.
//

import UIKit


class UsersTableViewCell: UITableViewCell {
    
    static let id = "UsersTableViewCell"
    
    private lazy var underView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemIndigo
        
        return view
    }()
    
    lazy var usersImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        //    iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "image2") ?? UIImage(systemName: "bell")
 
        return iv
    }()
    
    private lazy var usersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Custom cell"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir", size: 18)
        
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        setupCell()
        hz()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
      //  hz()
        
        
        self.underView.layer.cornerRadius = 12
    }
    
    
    func hz() {
        self.usersLabel.clipsToBounds = true
        self.usersImageView.layer.cornerRadius = usersImageView.frame.width / 2
        self.usersImageView.layer.borderWidth = 1
        self.usersImageView.layer.borderColor = UIColor.red.cgColor
    }
    
    func cellSetValues(_ email: String) {
        self.usersLabel.text = email
    }
    
    
    private func setupCell() {
        self.contentView.addSubview(underView)
        NSLayoutConstraint.activate([
            self.underView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7),
            self.underView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.underView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            self.underView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -7)
        ])
        
        self.underView.addSubview(usersImageView)
        NSLayoutConstraint.activate([
          //  self.usersImageView.topAnchor.constraint(equalTo: self.underView.topAnchor, constant: 10),
            self.usersImageView.leadingAnchor.constraint(equalTo: self.underView.leadingAnchor, constant: 20),
        //    self.usersImageView.bottomAnchor.constraint(equalTo: self.underView.bottomAnchor, constant: -10),
                    self.usersImageView.heightAnchor.constraint(equalToConstant: 90),
            self.usersImageView.widthAnchor.constraint(equalToConstant: 90),
            self.usersImageView.centerYAnchor.constraint(equalTo: self.underView.centerYAnchor)
        ])
        
        self.underView.addSubview(usersLabel)
        NSLayoutConstraint.activate([
            self.usersLabel.centerYAnchor.constraint(equalTo: self.underView.centerYAnchor),
            //    self.usersLabel.centerXAnchor.constraint(equalTo: self.underView.centerXAnchor),
            self.usersLabel.trailingAnchor.constraint(equalTo: self.underView.trailingAnchor, constant: -100)
            
        ])
    }
    
}
