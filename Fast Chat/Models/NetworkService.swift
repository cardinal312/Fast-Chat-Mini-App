//
//  NetworkService.swift
//  Fast Chat
//
//  Created by Macbook on 14/6/23.
//
import Firebase
import FirebaseAuth
//import FirebaseFirestore

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    
    
    func createNewUser(_ data: LoginField, complition: @escaping (ResponseCode) -> ()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { [weak self] result, err in
            if err == nil {
                if result != nil {
               //     let userID = result?.user.uid
            
                    complition(ResponseCode(code: 1))
                }
                
            } else {
                complition(ResponseCode(code: 0))
            }
        }
    }
    
    func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            if error != nil {
                print(error?.localizedDescription)
            }
        })
    }
}

