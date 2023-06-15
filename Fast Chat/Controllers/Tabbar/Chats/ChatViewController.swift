//
//  ChatViewController.swift
//  Fast Chat
//
//  Created by Macbook on 15/6/23.
//

import UIKit
import MessageKit
import InputBarAccessoryView

//MARK: - Protocols

struct Sender: SenderType {
    
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}


class ChatViewController: MessagesViewController {
    

    var chatID: String?
    var otherID: String?
    let service = NetworkService.shared
    let selfSender = Sender(senderId: "1", displayName: "")
    let otherSender = Sender(senderId: "2", displayName: "Jony")
    
    
    private var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // navigationController?.isNavigationBarHidden = false

        
        
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date().addingTimeInterval(-11200), kind: .text("Salam aleikum Islam")))
        
        messages.append(Message(sender: otherSender, messageId: "2", sentDate: Date().addingTimeInterval(-11200), kind: .text("Privet Cardinal")))
        
        messages.append(Message(sender: otherSender, messageId: "2", sentDate: Date().addingTimeInterval(-90200), kind: .text("Kak ty?")))
        
        
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        showMessageTimestampOnSwipeLeft = true
        
       messagesCollectionView.clipsToBounds = true
 
        
        
       
        //self.navigationItem.setHidesBackButton(true, animated: true)
        
    
       
        
    }
}

//MARK: - Protocols

extension ChatViewController: MessagesDisplayDelegate, MessagesLayoutDelegate, MessagesDataSource {
    
    func currentSender() -> MessageKit.SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        messages.count
    }
    
    
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    internal func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        let msg = Message(sender: selfSender, messageId: "ff23123", sentDate: Date(), kind: .text(text))
        messages.append(msg)
        
        service.sendMessage(otherID: self.otherID!, converID: self.chatID!, message: msg, text: text) { [weak self] isSend in
            
            DispatchQueue.main.async {
                inputBar.inputTextView.text = nil
                self?.messagesCollectionView.reloadDataAndKeepOffset()
                
            }
        }
    }
}

