//
//  SessionManager.swift
//  The-Great-Sound-Experiment-iOS
//
//  Created by Jorge on 11/07/2019.
//  Copyright © 2019 Ibercivis. All rights reserved.
//

import UIKit

class SessionManager {
    
    var key_token : String
    var key_username : String
    var key_userId : String
    var key_isLoggedIn : Bool
    
    init(token: String, username: String, userId: String, isLoggedIn: Bool) {
        key_token = token
        key_username = username
        key_userId = userId
        key_isLoggedIn = isLoggedIn
    }
    
    
    func setKeys(key_token: String, key_username: String, key_userId: String, key_isLoggedIn: Bool){
        let preferences = UserDefaults.standard
        print("saveAccessToken : \(key_token)")
        preferences.set(key_token, forKey: "token")
        preferences.set(key_username, forKey: "username")
        preferences.set(key_isLoggedIn, forKey: "isLogged")
        preferences.set(key_userId, forKey: "userId")
        // Checking the preference is saved or not
        didSave(preferences: preferences)
    }
    
    func getAccessToken() -> String{
        let preferences = UserDefaults.standard
        if preferences.string(forKey: "access_token") != nil{
            let key_token = preferences.string(forKey: "token")
            return key_token!
        } else {
            return ""
        }
    }
    
    // Checking the UserDefaults is saved or not
    func didSave(preferences: UserDefaults){
        let didSave = preferences.synchronize()
        if !didSave{
            // Couldn't Save
            print("Preferences could not be saved!")
        }
    }
    
    func clearKeys() {
        let preferences = UserDefaults.standard
        preferences.set("", forKey: "token")
        preferences.set("", forKey: "username")
        preferences.set(false, forKey: "isLogged")
        preferences.set("", forKey: "userId")
        // Checking the preference is saved or not
        didSave(preferences: preferences)
    }
    
    func getToken() -> String {
        let preferences = UserDefaults.standard
        let token = preferences.string(forKey: "token")
        
        return token ?? ""}
    
    func getIdUser() -> String {
        let preferences = UserDefaults.standard
        let userid = preferences.string(forKey: "userId")
        
        return userid ?? ""}
    
    func isLogged() -> Bool {
        let preferences = UserDefaults.standard
        let logged = preferences.bool(forKey: "isLogged")
        return logged}
    
    
    
}
