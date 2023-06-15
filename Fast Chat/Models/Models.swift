//
//  Slides.swift
//  Fast Chat
//
//  Created by Macbook on 10/6/23.
//

import UIKit

struct Slides {
    let id: Int
    let image: UIImage?
}


enum AuthResponse {
    case success, noVerify, error
}


struct LoginField {
    var email: String
    var password: String
}


struct ResponseCode {
    var code: Int
}
