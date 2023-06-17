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
        
        let tb = UITableView(frame: .zero, style: .plain)
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tb.register(UsersTableViewCell.self, forCellReuseIdentifier: UsersTableViewCell.id)
        tb.clipsToBounds = true
        tb.bounces = false
        tb.backgroundColor = .none
        tb.separatorStyle = .none
        tb.delegate = self
        tb.dataSource = self
        tb.showsVerticalScrollIndicator = false

        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        title = "Users"
        
        tableViewConfigure()
        getDataFromDataBase()
    }
    
    
    private func getDataFromDataBase() {
        self.servise.getAllUsers { [weak self] users in
            self?.userArray = users
            
            DispatchQueue.main.async {
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
        
        cell.backgroundColor = .systemIndigo
        cell.layer.cornerRadius = 12
        cell.selectionStyle = .none
    //    cell.hz()
        let cellname = userArray[indexPath.row]
        cell.cellSetValues(cellname.email)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userId = userArray[indexPath.row].id
        
        let vc = ChatViewController()
        vc.otherId = userId
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}
