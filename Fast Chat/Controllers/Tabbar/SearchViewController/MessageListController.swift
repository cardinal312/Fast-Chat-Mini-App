//
//  MessageListController.swift
//  Fast Chat
//
//  Created by Macbook on 12/6/23.
//

import UIKit
import InputBarAccessoryView
import MessageKit


class MessageListController: UIViewController {
    
    private var servise = NetworkService.shared
    private var userArray = [CurrentUser]()
    
    
    private lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //     tb.bounces = false
        tb.backgroundColor = .none
        tb.separatorStyle = .singleLine
        tb.delegate = self
        tb.dataSource = self
        tb.showsVerticalScrollIndicator = false
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemIndigo
        
        tableViewConfigure()
        
        servise.getAllUsers { [weak self] usersID in
            DispatchQueue.main.async {
                self?.userArray = usersID
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

extension MessageListController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGray2
        cell.selectionStyle = .blue
        
        cell.textLabel?.text = userArray[indexPath.row].id
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
        
        
        
        // id of conversations
        //let id = userArray[indexPath.row].id
        //let vc = ConversationViewController()
       // vc.chatID = id
       //  vc.otherId = "DZYNiUFxj6X8XwLMssepq3nK7Xy1"        // DZYNiUFxj6X8XwLMssepq3nK7Xy1 me
        
            
     //   navigationController?.pushViewController(vc, animated: false)
    }
}

extension MessageListController: InputBarAccessoryViewDelegate {
    
    
    
}

