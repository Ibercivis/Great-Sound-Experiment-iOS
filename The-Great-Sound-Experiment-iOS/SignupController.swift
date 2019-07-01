//
//  SignupController.swift
//  The-Great-Sound-Experiment-iOS
//
//  Created by Jorge on 18/06/2019.
//  Copyright © 2019 Ibercivis. All rights reserved.
//

import UIKit

class SignupController: UIViewController {
    
    
    @IBOutlet weak var applySignButton: UIButton!
    
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
    
    
    var age = ["-20","21-30","31-60", "61-70", "71-80", "80+"]
    var gender = ["Male", "Female", "Other"]
    var formation = ["None", "At school", "Extracurricular", "Conservatory"]
    var headphones = ["Inear", "Headset"]
    var priceRange = ["-10€","10-20€", "20-50€", "50-100€", "+100€"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genderTable.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        applySignButton.layer.cornerRadius = 8
        
    }
    
    @IBAction func genderDropDown(_ sender: Any) {
        if genderTable.isHidden == true {
            UIView.animate(withDuration: 0.3) {
                self.genderTable.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.genderTable.isHidden = true
            }
        }
}
    
    @IBAction func ageDropDown(_ sender: Any) {
        if ageTable.isHidden == true {
            UIView.animate(withDuration: 0.3) {
                self.ageTable.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.ageTable.isHidden = true
            }
        }
    }
    
    @IBAction func formationDropDown(_ sender: Any) {
        if formationTable.isHidden == true {
            UIView.animate(withDuration: 0.3) {
                self.formationTable.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.formationTable.isHidden = true
            }
        }
    }
    
    @IBAction func hpDropDown(_ sender: Any) {
        if HPTable.isHidden == true {
            UIView.animate(withDuration: 0.3) {
                self.HPTable.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.HPTable.isHidden = true
            }
        }
    }
    
    
    @IBAction func priceDropDown(_ sender: Any) {
        if priceTable.isHidden == true {
            UIView.animate(withDuration: 0.3) {
                self.priceTable.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.priceTable.isHidden = true
            }
        }
    }
}

extension SignupController: UITableViewDelegate, UITableViewDataSource {
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
        let genderCell = tableView.dequeueReusableCell(withIdentifier: "gendercell", for: indexPath)
        genderCell.textLabel?.text = gender[indexPath.row]
        return genderCell
        } else if tableView == ageTable {
            let ageCell = tableView.dequeueReusableCell(withIdentifier: "agecell", for: indexPath)
            ageCell.textLabel?.text = age[indexPath.row]
            return ageCell
        } else if tableView == formationTable {
            let formationCell = tableView.dequeueReusableCell(withIdentifier: "formationcell", for: indexPath)
            formationCell.textLabel?.text = formation[indexPath.row]
            return formationCell
        } else if tableView == HPTable {
            let hpCell = tableView.dequeueReusableCell(withIdentifier: "hpcell", for: indexPath)
            hpCell.textLabel?.text = headphones[indexPath.row]
            return hpCell
        } else {
            let priceCell = tableView.dequeueReusableCell(withIdentifier: "pricecell", for: indexPath)
            priceCell.textLabel?.text = priceRange[indexPath.row]
            return priceCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == genderTable {
            genderButton.setTitle("\(gender[indexPath.row])", for: .normal)
            if genderTable.isHidden == true {
                UIView.animate(withDuration: 0.3) {
                    self.genderTable.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.genderTable.isHidden = true
                }
            }
        }
        if tableView == ageTable {
            ageButton.setTitle("\(age[indexPath.row])", for: .normal)
            if ageTable.isHidden == true {
                UIView.animate(withDuration: 0.3) {
                    self.ageTable.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.ageTable.isHidden = true
                }
    } }
        if tableView == formationTable {
            formationButton.setTitle("\(formation[indexPath.row])", for: .normal)
            if formationTable.isHidden == true {
                UIView.animate(withDuration: 0.3) {
                    self.formationTable.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.formationTable.isHidden = true
                }
    } }
        if tableView == HPTable {
            HPButton.setTitle("\(headphones[indexPath.row])", for: .normal)
            if HPTable.isHidden == true {
                UIView.animate(withDuration: 0.3) {
                    self.HPTable.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.HPTable.isHidden = true
                }
    } }
        if tableView == priceTable {
            priceButton.setTitle("\(headphones[indexPath.row])", for: .normal)
            if priceTable.isHidden == true {
                UIView.animate(withDuration: 0.3) {
                    self.priceTable.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.priceTable.isHidden = true
                }
            }
        
    }
    
    
}


}
