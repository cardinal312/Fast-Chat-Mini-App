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
 //       private var userArray = [String]()
        
        
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
            return 5
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.backgroundColor = .systemGray2
         //   cell.layer.cornerRadius = 12
            cell.selectionStyle = .blue
            cell.textLabel?.text = "Simple cell"

            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print(indexPath.row)
            
            // id of conversations
            let vc = ChatViewController()
            vc.chatID = "first_chat_id"
            vc.otherID = "DZYNiUFxj6X8XwLMssepq3nK7Xy1"
            navigationController?.pushViewController(vc, animated: false)
        }
        
    }

extension MessageListController: InputBarAccessoryViewDelegate {
    
    
    
}

