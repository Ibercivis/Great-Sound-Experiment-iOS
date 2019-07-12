//
//  ProfileController.swift
//  The-Great-Sound-Experiment-iOS
//
//  Created by Jorge on 10/07/2019.
//  Copyright © 2019 Ibercivis. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Alamofire

struct UpdateStruct {
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

struct Sample:Codable{
    var result : Int
    var message : String
    var data : Datos
    
    }


struct Datos:Codable {
    var username : String
    var email : String
    var edad : String
    var sexo : String
    var formacion_musical : String
    var rango_precio : String
    var tipo_auriculares : String
    
}

class ProfileController: UIViewController {
    
    var sample:Sample?

    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var genderTable: UITableView!
    @IBOutlet weak var ageButton: UIButton!
    @IBOutlet weak var ageTable: UITableView!
    @IBOutlet weak var formationButton: UIButton!
    @IBOutlet weak var formationTable: UITableView!
    @IBOutlet weak var HPButton: UIButton!
    @IBOutlet weak var HPTable: UITableView!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var priceTable: UITableView!
    @IBOutlet weak var userText: UILabel!
    
    
    @IBOutlet weak var modifyButton: UIButton!
    @IBOutlet weak var closeSessionButton: UIButton!
    
    var age = ["-20","21-30","31-60", "61-70", "71-80", "80+"]
    var gender = ["Male", "Female", "Other"]
    var formation = ["None", "At school", "Extracurricular", "Conservatory"]
    var headphones = ["Inear", "Headset"]
    var priceRange = ["-10€","10-20€", "20-50€", "50-100€", "+100€"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        genderTable.isHidden = true
        ageTable.isHidden = true
        formationTable.isHidden = true
        HPTable.isHidden = true
        priceTable.isHidden = true
        
        getProfileRequest()
        
        modifyButton.layer.cornerRadius = 10
        closeSessionButton.layer.cornerRadius = 10
    }
    
    @IBAction func lanzarUpdate(_ sender: Any) {
        actualizarProfile()
    }
    
    
    @IBAction func cerrarSesion(_ sender: Any) {
        let session = SessionManager(token: "0", username: "", userId: "0", isLoggedIn: true)
        session.clearKeys()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Splash")
        self.present(newViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func onClickGeneroDD(_ sender: Any) {
        if genderTable.isHidden {
            animateTable(toogle: false, latabla: genderTable)
        } else {
            animateTable(toogle: true, latabla: genderTable)
        }
    }
    @IBAction func onClickEdadDD(_ sender: Any) {
        if ageTable.isHidden {
            animateTable(toogle: false, latabla: ageTable)
        } else {
            animateTable(toogle: true, latabla: ageTable)
        }
    }
    @IBAction func onClickFormacionDD(_ sender: Any) {
        if formationTable.isHidden {
            animateTable(toogle: false, latabla: formationTable)
        } else {
            animateTable(toogle: true, latabla: formationTable)
        }
    }
    @IBAction func onClickCascosDD(_ sender: Any) {
        if HPTable.isHidden {
            animateTable(toogle: false, latabla: HPTable)
        } else {
            animateTable(toogle: true, latabla: HPTable)
        }
    }
    
    
    @IBAction func onClickPrecioDD(_ sender: Any) {
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
    
    func dataFromJSONObject(data: Data) {
        
        do {
            
            let samples234 : Sample = try JSONDecoder.init().decode(Sample.self, from: data)
            if(samples234.result == 1){
            let datauser = samples234.data
            print(datauser.email)
               
            } else {print("Algo ha fallado recibiendo los datos")}
        } catch {
            
            print(error.localizedDescription)
            
        }
        
    }
    
    func getProfileRequest(){
        
        var datosdatos : Datos?
        let preferences = UserDefaults.standard
        
        let idUser : String = preferences.value(forKey: "userId") as! String
        let token : String = preferences.value(forKey: "token") as! String
    
        
        let urlString = "https://gse.ibercivis.es"+"/getUserInfo.php?idUser="+idUser+"&token="+token
        print(urlString)
        
        Alamofire.request(urlString, method: .get, encoding: URLEncoding.default).responseJSON {
            response in
            let data = response.data
            print(response)
            do {
                guard let jsonArray = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : Any] else { return }
                
                print(jsonArray)
                
                do {
                    
                    let samples234 : Sample = try JSONDecoder.init().decode(Sample.self, from: data!)
                    if(samples234.result == 1){
                        let datauser = samples234.data
                        self.userText.text = datauser.username
                        print(datauser.username)
                        self.genderButton.setTitle("\(datauser.sexo)", for: .normal)
                        self.animateTable(toogle: true, latabla: self.genderTable)
                        self.ageButton.setTitle(datauser.edad, for: .normal)
                        self.animateTable(toogle: true, latabla: self.ageTable)
                        self.formationButton.setTitle("\(datauser.formacion_musical)", for: .normal)
                        self.animateTable(toogle: true, latabla: self.formationTable)
                        self.HPButton.setTitle("\(datauser.tipo_auriculares)", for: .normal)
                        self.animateTable(toogle: true, latabla: self.HPTable)
                        self.priceButton.setTitle("\(datauser.rango_precio)", for: .normal)
                        self.animateTable(toogle: true, latabla: self.priceTable)
                    }
                    
                } catch {print(error.localizedDescription)}
            } catch {
                print("Error serializing JSON")
                self.toastMessage("Algo ha fallado obteniendo sus datos.")
            }
            
            
            
            
            
            switch response.result {
            case .success:
                print(response)
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
        
    }
    
    func actualizarProfile(){
        let preferences = UserDefaults.standard
        
        let idUser : String = preferences.value(forKey: "userId") as! String
        let token : String = preferences.value(forKey: "token") as! String
        
        
        let urlString = "https://gse.ibercivis.es/updateUserInfo.php"
        
        Alamofire.request(urlString, method: .post, parameters: ["idUser": idUser, "token": token, "edad": ageButton.currentTitle!, "sexo": genderButton.currentTitle!, "formacion_musical": formationButton.currentTitle!, "tipo_auriculares": HPButton.currentTitle!, "rango_precio": priceButton.currentTitle! ],encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            let data = response.data
            print(response)
            do {
                guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : Any] else { return }
                
                let course = UpdateStruct(json: json)
                
                
                
                if(course.result == 1) {
                    
                    
                    self.toastMessage("Información actualizada")
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
        
        
    }
        
    }


extension ProfileController: UITableViewDelegate, UITableViewDataSource {
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
        if tableView == HPTable {
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
        } else if tableView == HPTable {
            let hpCell = HPTable.dequeueReusableCell(withIdentifier: "hpcell", for: indexPath)
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
        if tableView == HPTable {
            HPButton.setTitle("\(headphones[indexPath.row])", for: .normal)
            animateTable(toogle: true, latabla: HPTable) }
        if tableView == priceTable {
            priceButton.setTitle("\(priceRange[indexPath.row])", for: .normal)
            animateTable(toogle: true, latabla: priceTable)
        }
        
        
    }
    
    
}
