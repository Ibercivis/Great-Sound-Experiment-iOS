//
//  StatsController.swift
//  The-Great-Sound-Experiment-iOS
//
//  Created by Jorge on 10/07/2019.
//  Copyright © 2019 Ibercivis. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class StatsController: UIViewController {
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var filterTable: UITableView!
    @IBOutlet weak var marcoCard: UIView!
    
    var filter = ["General","Men", "Women", "Headphones +30€", "Headphones -30€"]
    
    
    @IBOutlet weak var logoLevel: UIStackView!
    @IBOutlet weak var resumenLevel: UILabel!
    @IBOutlet weak var barraGeneral: UIProgressView!
    @IBOutlet weak var numeroGeneral: UILabel!
    @IBOutlet weak var numeroIndividual: UILabel!
    @IBOutlet weak var numeroDiario: UILabel!
    @IBOutlet weak var barraIndividual: UIProgressView!
    @IBOutlet weak var barraDiario: UIProgressView!
    @IBOutlet weak var elegirNivel: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        marcoCard.layer.cornerRadius = 10
    
    }
    @IBAction func filterDD(_ sender: Any) {
        if filterTable.isHidden {
            animateTable(toogle: false, latabla: filterTable)
        } else {
            animateTable(toogle: true, latabla: filterTable)
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

extension StatsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let filterCell = filterTable.dequeueReusableCell(withIdentifier: "filtercell", for: indexPath)
            filterCell.textLabel?.text = filter[indexPath.row]
            return filterCell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == filterTable {
            filterButton.setTitle("\(filter[indexPath.row])", for: .normal)
            animateTable(toogle: true, latabla: filterTable)
        }
    }
}
