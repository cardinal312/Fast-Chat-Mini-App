//
//  UsersViewController.swift
//  Fast Chat
//
//  Created by Macbook on 12/6/23.
//

import UIKit

class UsersViewController: UIViewController {
    
    private var servise = NetworkService.shared
    private var userArray = [CurrentUser]()
    
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.register(UsersTableViewCell.self, forCellReuseIdentifier: UsersTableViewCell.id)
        tv.bounces = false
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Helpers.Localization.userList
        
        self.view.backgroundColor = .systemBackground
        //        navigationItem.title = "Users"
        //        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableViewConfigure()
        getDataFromDataBase()
        
        
    }
    
    
    
    
    private func getDataFromDataBase() {
        self.servise.getAllUsers { [weak self] users in
            self?.userArray = users
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    
    private func tableViewConfigure() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - Delegates

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.id, for: indexPath) as? UsersTableViewCell else { return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) }
        
        
        //        cell.clipsToBounds = true
        //        cell.backgroundColor = .systemIndigo
        //        cell.layer.cornerRadius = 12
        
        //TODO: - Make to change personal data of user in db
        let cellname = userArray[indexPath.row]
        
        DispatchQueue.main.async { 
            cell.cellSetValues(cellname)
            self.tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userId = userArray[indexPath.row].id
        
        let vc = ConversationViewController()
        vc.modalPresentationStyle = .popover
        vc.otherId = userId
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}
