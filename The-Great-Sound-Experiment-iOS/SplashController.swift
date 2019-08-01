//
//  SplashController.swift
//  The-Great-Sound-Experiment-iOS
//
//  Created by Jorge on 12/07/2019.
//  Copyright © 2019 Ibercivis. All rights reserved.
//

import UIKit
import Alamofire

class SplashController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let preferences = UserDefaults.standard
        
        if (preferences.value(forKey: "userId") != nil) {
        let idUser : String = preferences.value(forKey: "userId") as! String
        print(idUser)
        if (idUser.isEmpty == true){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Nav")
            present(newViewController, animated: true, completion: nil)
        } else if (idUser == ""){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Nav")
            present(newViewController, animated: true, completion: nil)
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Tab")
            present(newViewController, animated: true, completion: nil)
        }
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Nav")
            present(newViewController, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
}
