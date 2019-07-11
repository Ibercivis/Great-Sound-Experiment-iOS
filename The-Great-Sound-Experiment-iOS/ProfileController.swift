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

class ProfileController: UIViewController {

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
        
        modifyButton.layer.cornerRadius = 10
        closeSessionButton.layer.cornerRadius = 10
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
