//
//  Nivel1Controller.swift
//  The-Great-Sound-Experiment-iOS
//
//  Created by Jorge on 18/06/2019.
//  Copyright © 2019 Ibercivis. All rights reserved.
//

import UIKit

class Nivel1Controller: UIViewController {
    
    @IBOutlet weak var marcoRespuesta: UIView!
    @IBOutlet weak var audio1Button: UIButton!
    @IBOutlet weak var audio2Button: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        marcoRespuesta.layer.cornerRadius = 8
        audio1Button.layer.cornerRadius = 6
        audio2Button.layer.cornerRadius = 6
    }
    
    
}
