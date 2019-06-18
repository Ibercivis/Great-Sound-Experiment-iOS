//
//  ViewController.swift
//  The-Great-Sound-Experiment-iOS
//
//  Created by Jorge on 18/06/2019.
//  Copyright © 2019 Ibercivis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        signupButton.layer.cornerRadius = 6
        loginButton.layer.cornerRadius = 6
    }


}


