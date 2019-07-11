//
//  pruebascroll.swift
//  The-Great-Sound-Experiment-iOS
//
//  Created by Jorge on 03/07/2019.
//  Copyright © 2019 Ibercivis. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

struct SignUpStruct {
    var result : Int
    var username : String
    var email : String
    var password : String
    var edad : String
    var sexo : String
    var formacion_musical : String
    var rango_precio : String
    var tipo_auriculares : String
    
    init(json: [String : Any]) {
        
        result = json["result"] as? Int ?? 0
        username = json["username"] as? String ?? ""
        email = json["email"] as? String ?? ""
        password = json["password"] as? String ?? ""
        edad = json["edad"] as? String ?? ""
        sexo = json["sexo"] as? String ?? ""
        formacion_musical = json["formacion_musical"] as? String ?? ""
        rango_precio = json["rango_precio"] as? String ?? ""
        tipo_auriculares = json["tipo_auriculares"] as? String ?? ""
        
    }
}

class pruebascroll: UIViewController {
    
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var genderTable: UITableView!
    
    @IBOutlet weak var ageButton: UIButton!
    @IBOutlet weak var ageTable: UITableView!
    
    @IBOutlet weak var formationButton: UIButton!
    @IBOutlet weak var formationTable: UITableView!
    
    @IBOutlet weak var headphonesButton: UIButton!
    @IBOutlet weak var headphonesTable: UITableView!
    
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var priceTable: UITableView!
    
    
    @IBOutlet weak var applySignButton: UIButton!
    
    var age = ["-20","21-30","31-60", "61-70", "71-80", "80+"]
    var gender = ["Male", "Female", "Other"]
    var formation = ["None", "At school", "Extracurricular", "Conservatory"]
    var headphones = ["Inear", "Headset"]
    var priceRange = ["-10€","10-20€", "20-50€", "50-100€", "+100€"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genderTable.isHidden = false
        ageTable.isHidden = false
        formationTable.isHidden = true
        headphonesTable.isHidden = true
        priceTable.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        applySignButton.layer.cornerRadius = 10
    }
    
    @IBAction func lanzarSignUpRequest(_ sender: Any) {
        SignUpRequest()
    }
    
    
    @IBAction func onClickGenderDD(_ sender: Any) {
        if genderTable.isHidden {
            animateTable(toogle: false, latabla: genderTable)
        } else {
            animateTable(toogle: true, latabla: genderTable)
        }
    }
    
    @IBAction func onClickAgeDD(_ sender: Any) {
        if ageTable.isHidden {
            animateTable(toogle: false, latabla: ageTable)
        } else {
            animateTable(toogle: true, latabla: ageTable)
        }
    }
    
    @IBAction func onClickFormationDD(_ sender: Any) {
        if formationTable.isHidden {
            animateTable(toogle: false, latabla:formationTable)
        } else {
            animateTable(toogle: true, latabla: formationTable)
        }
    }
    
    @IBAction func onClickHeadphonesDD(_ sender: Any) {
        if headphonesTable.isHidden {
            animateTable(toogle: false, latabla: headphonesTable)
        } else {
            animateTable(toogle: true, latabla: headphonesTable)
        }
    }
    
    @IBAction func onClickPriceDD(_ sender: Any) {
        if priceTable.isHidden {
            animateTable(toogle: false, latabla: priceTable)
        } else {
            animateTable(toogle: true, latabla: priceTable)
        }
    }
    
    
     func animateTable( toogle: Bool, latabla: UITableView){
        if toogle {
            UIView.animate(withDuration: 0.3){
                latabla.isHidden = true
            }
        } else {
            UIView.animate(withDuration: 0.3){
                latabla.isHidden = false
            }
        }
    }
    
    func SignUpRequest() {
        
        if (userText.text! != "") {
            
            let urlString = "https://gse.ibercivis.es/signup.php"
            print(userText.text!)
            print(passwordText.text!)
            print(emailText.text!)
            
            Alamofire.request(urlString, method: .post, parameters: ["username": userText.text!, "password" : passwordText.text!, "email": emailText.text!, "edad": ageButton.currentTitle!, "sexo": genderButton.currentTitle!, "formacion_musical": formationButton.currentTitle!, "tipo_auriculares": headphonesButton.currentTitle!, "rango_precio": priceButton.currentTitle! ],encoding: URLEncoding.default, headers: nil).responseJSON {
                response in
                let data = response.data
                print(response)
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : Any] else { return }
                    
                    let course = SignUpStruct(json: json)
                    
                    
                    
                    if(course.result == 1) {
                        
        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Jugar")
                        self.present(newViewController, animated: true, completion: nil)
                    } else {self.toastMessage("Algo ha fallado. Revise sus datos.")}
                    
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


extension pruebascroll: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == genderTable {
            return gender.count
        }
        if tableView == ageTable {
            return age.count
        }
        if tableView == formationTable {
            return formation.count
        }
        if tableView == headphonesTable {
            return headphones.count
        } else {
            return priceRange.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == genderTable {
            let genderCell = genderTable.dequeueReusableCell(withIdentifier: "gendercell", for: indexPath)
            genderCell.textLabel?.text = gender[indexPath.row]
            return genderCell
        } else if tableView == ageTable {
            let ageCell = ageTable.dequeueReusableCell(withIdentifier: "agecell", for: indexPath)
            ageCell.textLabel?.text = age[indexPath.row]
            return ageCell
        } else if tableView == formationTable {
            let formationCell = formationTable.dequeueReusableCell(withIdentifier: "formationcell", for: indexPath)
            formationCell.textLabel?.text = formation[indexPath.row]
            return formationCell
        } else if tableView == headphonesTable {
            let hpCell = headphonesTable.dequeueReusableCell(withIdentifier: "hpcell", for: indexPath)
            hpCell.textLabel?.text = headphones[indexPath.row]
            return hpCell
        } else {
            let priceCell = priceTable.dequeueReusableCell(withIdentifier: "pricecell", for: indexPath)
            priceCell.textLabel?.text = priceRange[indexPath.row]
            return priceCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == genderTable {
            genderButton.setTitle("\(gender[indexPath.row])", for: .normal)
            animateTable(toogle: true, latabla: genderTable)
        }
        if tableView == ageTable {
            ageButton.setTitle("\(age[indexPath.row])", for: .normal)
            animateTable(toogle: true, latabla: ageTable)}
        if tableView == formationTable {
            formationButton.setTitle("\(formation[indexPath.row])", for: .normal)
            animateTable(toogle: true, latabla: formationTable) }
        if tableView == headphonesTable {
            headphonesButton.setTitle("\(headphones[indexPath.row])", for: .normal)
            animateTable(toogle: true, latabla: headphonesTable) }
        if tableView == priceTable {
            priceButton.setTitle("\(priceRange[indexPath.row])", for: .normal)
            animateTable(toogle: true, latabla: priceTable)
        }
        
        
    }
    
    
    
    
}


