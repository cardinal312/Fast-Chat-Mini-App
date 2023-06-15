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
                    if result.user.isEmailVerified {
                        complition(.success)
                    } else {
                        self?.confirmEmail()
                        complition(.noVerify)
                    }
                }
            }
        }
    }
    
    
    func getAllUsers(complition: @escaping ([String]) -> ()) {
        Firestore.firestore().collection("users").getDocuments { [weak self] snap, error in
            if error == nil {
                var emailList = [String]()
                if let docs = snap?.documents {
                    for doc in docs {
                        let data = doc.data()
                        let email = data["email"] as? String
                        emailList.append(email ?? "fuck you ****")
                    }
                }
                complition(emailList)
            }
        }
    }
    
    
    //MARK: - Messanger
    
    func sendMessage(otherID: String, converID: String, message: Message, text: String, complition: @escaping (Bool) -> ()) {
        if converID == nil {
            //create new chats dialog
            
        } else {
            // chat dialog haved
            let msg: [String: Any] = [
                "date": Date(),
                "sender": message.sender.senderId,
                "text": text ]
            
            Firestore.firestore().collection("conversations").document(converID).collection("messages").addDocument(data: msg) { error in
                if error == nil {
                    complition(true)
                } else {
                    complition(false)
                }
                
            }
        }
    }
    
    func updateConver() {
        
    }
    
    func getConvoID() {
        
    }
    
    func getAllMessages() {
        
    }
    
    func getOneMessage() {
        
        
    }
    
}

