//
//  LoginController.swift
//  The-Great-Sound-Experiment-iOS
//
//  Created by Jorge on 18/06/2019.
//  Copyright © 2019 Ibercivis. All rights reserved.
//

import UIKit
import Alamofire

struct LoginStruct {
    var idUser : String
    var result : Int
    var token : String
    var username : String
    
    init(json: [String : Any]) {
        idUser = json["idUser"] as? String ?? ""
        result = json["result"] as? Int ?? 0
        token = json["token"] as? String ?? ""
        username = json["username"] as? String ?? ""
        
    }
}


class LoginController: UIViewController {
    
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        applyButton.layer.cornerRadius = 6
        
    }
    @IBAction func makeLogin(_ sender: Any) {
        LoginRequest()
    }
    
    func LoginRequest() {
        
        if (usernameTxt.text! != "") {
            
            let urlString = "https://gse.ibercivis.es/login.php"
            print(passwordTxt.text!)
            print(usernameTxt.text!)
            
            Alamofire.request(urlString, method: .post, parameters: ["username": usernameTxt.text!, "password" : passwordTxt.text!],encoding: URLEncoding.default, headers: nil).responseJSON {
                response in
                let data = response.data
                print(response)
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : Any] else { return }
                    
                    let course = LoginStruct(json: json)
                    
                    
                    var session = SessionManager(token: course.token, username: course.username, userId: course.idUser, isLoggedIn: true)
                    
                    
                    if(course.result == 1) {
                        session.setKeys(key_token: course.token, key_username: course.username, key_userId: course.idUser, key_isLoggedIn: true)
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Jugar")
                        self.present(newViewController, animated: true, completion: nil)
                    } else {self.toastMessage("Algo ha fallado. Revise sus datos.")}
                    
                    print(course.idUser)
                    print(course.result)
                    print(course.token)
                    print(course.username)
                } catch {
                    print("Error serializing JSON")
                    self.toastMessage("Algo ha fallado. Revise sus datos.")
                }
                
                
                
                
                
                switch response.result {
                case .success:
                    print(response)
                    
                    break
                case .failure(let error):
                    
                    print(error)
                }
            }
            
        } else { self.toastMessage("Debes escribir nombre de usuario y contraseña")
            print("Debes escribir nombre de usuario y contraseña")
            
        }
            
        }
        
        
    
    
}

