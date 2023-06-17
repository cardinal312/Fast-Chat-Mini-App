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
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}


class ChatViewController: MessagesViewController {
    
    var chatID: String?
    var otherId: String?
    let service = NetworkService.shared
    let selfSender = Sender(senderId: "1", displayName: "")
    let otherSender = Sender(senderId: "2", displayName: "")
    
    
    private var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //     navigationController?.isNavigationBarHidden = false
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        showMessageTimestampOnSwipeLeft = true
        messagesCollectionView.clipsToBounds = true
        //self.navigationItem.setHidesBackButton(true, animated: true)
        
        // if chatid == nil? , to do search
        
        if chatID == nil {
            service.getConvoId(otherId: otherId!) { [weak self] chatId in
                self?.chatID = chatId
                self?.getMessages(convoId: chatId)
            }
        }
            
        
        
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
    
    
    func getMessages(convoId: String) {
        service.getAllMessages(chatId: convoId) { [weak self] messages in
            self?.messages = messages
            
            DispatchQueue.main.async {
                self?.messagesCollectionView.reloadDataAndKeepOffset()
            }
            
                
        }
    }
    
    
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        let msg = Message(sender: selfSender, messageId: "", sentDate: Date(), kind: .text(text))
        
        messages.append(msg)
        
        service.sendMessage(otherId: self.otherId!, convoId: self.chatID, text: text) { [weak self] convoId in
            
            DispatchQueue.main.async {
                inputBar.inputTextView.text = nil
                self?.messagesCollectionView.reloadDataAndKeepOffset()
            }
            
            self?.chatID = convoId
        }
    }
}

