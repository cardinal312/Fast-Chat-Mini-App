//
//  NetworkService.swift
//  Fast Chat
//
//  Created by Macbook on 14/6/23.
//
import Firebase
import FirebaseAuth
import FirebaseFirestore

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    
    
    func createNewUser(_ data: LoginField, complition: @escaping (ResponseCode) -> ()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { [weak self] result, err in
            if err == nil {
                if result != nil {
                    
                    let userID = result?.user.uid
                    let email = data.email
                    let data: [String: Any] = ["email": email]
                    
                    Firestore.firestore().collection("users").document(userID!).setData(data)
                    
                    
                    complition(ResponseCode(code: 1))
                }
                
            } else {
                complition(ResponseCode(code: 0))
            }
        }
    }
    
    func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { [weak self] error in
            if error != nil {
                print(error?.localizedDescription)
            }
        })
    }
    
    
    
    func authInApp(_ data: LoginField, complition: @escaping (AuthResponse) -> ()) {
        Auth.auth().signIn(withEmail: data.email, password: data.password) { [weak self] result, error in
            if error != nil {
                complition(.error)
            } else {
                if let result = result {
                    complition(.success)
//                    if result.user.isEmailVerified {
//                        complition(.success)
//                    } else {
//                        self?.confirmEmail()
//                        complition(.noVerify)
//                    }
                }
            }
        }
    }
    
    
    func getAllUsers(complition: @escaping ([CurrentUser]) -> ()) {
        
        guard let email = Auth.auth().currentUser?.email else { return }
        
        var currentUsers = [CurrentUser]()
        
        Firestore.firestore().collection("users")
            .whereField("email", isNotEqualTo: email)      // Its me in FB
            .getDocuments { snap, error in
                
            if error == nil {
                if let docs = snap?.documents {
                    for doc in docs {
                        let data = doc.data()
                        let userId = doc.documentID
                        let email = data["email"] as? String
                        
                        currentUsers.append(CurrentUser(id: userId, email: email ?? "data == nil, fuck you ****"))
                    }
                }
                complition(currentUsers)
            }
        }
    }
    
    
    //MARK: - Messanger
    
    func sendMessage(otherId: String, convoId: String?, text: String, complition: @escaping (String) -> ()) {
        
        let ref = Firestore.firestore()
        
        if let uid = Auth.auth().currentUser?.uid {
            if convoId == nil {
                       //create new chats dialog
                let convoId = UUID().uuidString
                
                
                let selfData: [String: Any] = [
                    "date": Date(),
                    "otherId": otherId
                ]
                
                let otherData: [String: Any] = [
                    "date": Date(),
                    "otherId": uid
                ]
                
                // we have chat with person X
                
                ref.collection("users")
                    .document(uid)
                    .collection("conversations")
                    .document(convoId)
                    .setData(selfData)
                
                // Person X have chat with me
                
                ref.collection("users")
                    .document(otherId)
                    .collection("conversations")
                    .document(convoId)
                    .setData(otherData)
                
                
                let msg: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text ]
                
                let convoInfo: [String: Any] = [
                    "date": Date(),
                    "selfSender": uid,
                    "otherSender": otherId
                    
                ]
                
                ref.collection("conversations")
                    .document(convoId)
                    .setData(convoInfo) { error in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        
                        ref.collection("conversations")
                            .document(convoId)
                            .collection("messages")
                            .addDocument(data: msg) { error in
                                if error == nil {
                                    complition(convoId)
                                }
                                
                            }
                        
                    }
                
                
            } else {
                // chat dialog haved
                
                let msg: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text]
                
                Firestore.firestore().collection("conversations").document(convoId!).collection("messages").addDocument(data: msg) { error in
                    
                    if error == nil {
                        complition(convoId!)
                    }
            }
        }
    }
}
    
    func updateConver() {
        
    }
    
    func getConvoId(otherId: String, completion: @escaping (String) -> ()) {
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Firestore.firestore()
            
            ref.collection("users")
                .document(uid)
                .collection("conversations")
                .whereField("otherId", isEqualTo: otherId)
                .getDocuments { snap, error in
                    if error != nil {
                        return
                    }
                    if let snap = snap, !snap.documents.isEmpty {
                        let doc = snap.documents.first
                      if let convoId = doc?.documentID {
                            completion(convoId)
                    }
                }
            }
        }
    }
    
    func getAllMessages(chatId: String, complition: @escaping ([Message]) -> ()) {
        
        if let uid = Auth.auth().currentUser?.uid {
            
            let ref = Firestore.firestore()
            ref.collection("conversations")
                .document(chatId)
                .collection("messages")
                .limit(to: 50)
                .order(by: "date" , descending: false)
                .addSnapshotListener { snap, error in
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }
                    
                    if let snap = snap, !snap.documents.isEmpty {
                        
                        var msgs = [Message]()
                        //Message(sender: selfSender, messageId: "", sentDate: Date(), kind: .text(text))
                        
                        var sender = Sender(senderId: uid, displayName: "Me")
                        
                        for doc in snap.documents {
                            let data = doc.data()
                            let userId = data["sender"] as! String
                            
                            let messageId = doc.documentID
                            
                            let date = data["date"] as! Timestamp
                            let sentDate = date.dateValue()
                            let text = data["text"] as! String
                            
                            if userId == uid {
                                sender = Sender(senderId: "1", displayName: "")
                            } else {
                                sender = Sender(senderId: "2", displayName: "")
                            }
                            
                            
                            
                            msgs.append(Message(sender: sender, messageId: messageId, sentDate: sentDate, kind: .text(text)))
                        }
                        complition(msgs)
                    }
                    
                }
            
        }
        
    }
    
    func getOneMessage() {
        
        
    }
    
}

