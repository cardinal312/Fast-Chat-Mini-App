//
//  Helpers.swift
//  Fast Chat
//
//  Created by Macbook on 25/10/23.
//

import UIKit

public enum Helpers {
    
    enum Localization {
        static let userList = "Users"
        static let search = "Search"
        static let settings = "Settings"
        
    }
    
    enum Image {
        static let userList = UIImage(systemName: "message")
        static let search = UIImage(systemName: "person")
        static let settings = UIImage(systemName: "gearshape")
        
        
        static let userListSelected = UIImage(systemName: "message.fill")
        static let searchSelected = UIImage(systemName: "person.fill")
        static let settingsSelected = UIImage(systemName: "gearshape.fill")
    }
    
    enum Styles {
        
        enum Colors {
            static let blue = UIColor.systemBlue
            static let purple = UIColor.purple
            
            static let gold = UIColor(hex: "#ffe700ff")
            static let chocolate = UIColor(hex: "#d2691e")
            static let goldenYellow = UIColor(hex: "#ffdf00")
            
        }
    }
    
}
