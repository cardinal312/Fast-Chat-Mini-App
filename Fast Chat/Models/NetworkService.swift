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
    
    
    
    
    
    
    
    
    
    
}

