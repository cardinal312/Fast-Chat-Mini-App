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
        view.backgroundColor = UIColor.gray//Helpers.Styles.Colors.purple
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var usersImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .systemBackground
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "logo") ?? UIImage(systemName: "person")
 
        return iv
    }()
    
    private lazy var usersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Custom cell"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.clipsToBounds = true
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        layer.cornerRadius = 12
        
        self.underView.layer.cornerRadius = 12
        self.underView.layer.borderWidth = 0.5
        self.underView.layer.borderColor = UIColor.black.cgColor
        
        
        self.usersImageView.layer.cornerRadius = usersImageView.frame.width / 2
        self.usersImageView.layer.borderWidth = 2
        self.usersImageView.layer.borderColor = UIColor.black.cgColor
        
        
    }
    
    
    func cellSetValues(_ userDB: CurrentUser) {
        self.usersLabel.text = userDB.email
        self.usersImageView.image = UIImage(systemName: userDB.avatar) ?? UIImage(systemName: "person")
    }
    
    
    private func setupCell() {
        self.contentView.addSubview(underView)
        NSLayoutConstraint.activate([
            self.underView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.underView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.underView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            self.underView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
        ])
        
        self.underView.addSubview(usersImageView)
        NSLayoutConstraint.activate([
            self.usersImageView.leadingAnchor.constraint(equalTo: self.underView.leadingAnchor, constant: 20),
            self.usersImageView.centerYAnchor.constraint(equalTo: self.underView.centerYAnchor),
            self.usersImageView.heightAnchor.constraint(equalToConstant: 90),
            self.usersImageView.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        self.underView.addSubview(usersLabel)
        NSLayoutConstraint.activate([
            self.usersLabel.centerYAnchor.constraint(equalTo: self.underView.centerYAnchor),
            self.usersLabel.leadingAnchor.constraint(equalTo: self.usersImageView.trailingAnchor, constant: 25)
            
        ])
    }
    
}
