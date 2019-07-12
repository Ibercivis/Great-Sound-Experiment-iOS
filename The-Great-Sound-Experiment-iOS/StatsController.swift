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
import Alamofire

struct StatsStruct {
    var percentageDay : String
    var percentageHistory : String
    var percentageGeneral : String
    var result : Int
    var message : String
    
    init(json: [String : Any]) {
        percentageDay = json["percentageDay"] as? String ?? ""
        percentageHistory = json["percentageHistory"] as? String ?? ""
        percentageGeneral = json["percentageGeneral"] as? String ?? ""
        result = json["result"] as? Int ?? 0
        message = json["message"] as? String ?? ""
        
    }
}

class StatsController: UIViewController {
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var filterTable: UITableView!
    @IBOutlet weak var marcoCard: UIView!
    @IBOutlet weak var segmentedLevels: UISegmentedControl!
    
    var filter = ["General","Hombres", "Mujeres", "Auriculares +30€", "Auriculares -30€"]
    
    
    
    @IBOutlet weak var logoLevel: UIImageView!
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
    @IBAction func selectedLevel(_ sender: Any) {
        
        switch segmentedLevels.selectedSegmentIndex {
        case 0:
            getStatsRequest(elnivel: 1)
            logoLevel.image = UIImage(named: "slevel1")
            resumenLevel.text = "WAV 8bits 22050 VS WAV 16bits 44100"
        case 1:
            getStatsRequest(elnivel: 2)
            logoLevel.image = UIImage(named: "slevel2")
            resumenLevel.text = "WAV 8bits 44100 VS WAV 16bits 44100"
        case 2:
            getStatsRequest(elnivel: 3)
            logoLevel.image = UIImage(named: "slevel3")
            resumenLevel.text = "MP3 64kbps VS WAV 16bits 44100"
        case 3:
            getStatsRequest(elnivel: 4)
            logoLevel.image = UIImage(named: "slevel4")
            resumenLevel.text = "MP3 64kbps VS MP3 192kbps"
        case 4:
            getStatsRequest(elnivel: 5)
            logoLevel.image = UIImage(named: "slevel5")
            resumenLevel.text = "MP3 320kbps VS WAV 16bits 44100"
        default:
            getStatsRequest(elnivel: 1)
        }
        
    }
    
    func getStatsRequest(elnivel : Int) {
        
        let preferences = UserDefaults.standard
        
        let idUser : String = preferences.value(forKey: "userId") as! String
        let token : String = preferences.value(forKey: "token") as! String
        var filtro : String = ""
        if(filterButton.currentTitle == "General"){
            filtro = ""
        } else if(filterButton.currentTitle == "Hombres"){
            filtro = "&sexo=Hombre"
        } else if(filterButton.currentTitle == "Mujeres"){
            filtro = "&sexo=Mujer"
        } else if(filterButton.currentTitle == "Auriculares +30€"){
            filtro = "&rango_precio=30"
        } else if (filterButton.currentTitle == "Auriculares -30€"){
            filtro = "&rango_precio=29"
        } else {filtro = ""}
        
        let querylevel : String = "&level=" + String(elnivel)
        
         let urlString = "https://gse.ibercivis.es"+"/level_statistics.php?idUser="+idUser+"&token="+token+filtro+"&level="+querylevel
        
        print(urlString)
        Alamofire.request(urlString, method: .get, encoding: URLEncoding.default).responseJSON{
            response in
            let data = response.data
            print(response)
            do {
                guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : Any] else { return }
                
                let course = StatsStruct(json: json)
                
                self.barraGeneral.progress = Float(course.percentageGeneral) as! Float
                self.barraIndividual.progress = Float(course.percentageHistory) as! Float
                self.barraDiario.progress = Float(course.percentageDay) as! Float
                self.numeroGeneral.text = course.percentageGeneral
                self.numeroIndividual.text = course.percentageHistory
                self.numeroDiario.text = course.percentageDay
        
            } catch {print(error.localizedDescription)}
        
    }
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
            getStatsRequest(elnivel: (segmentedLevels.selectedSegmentIndex+1))
            print((segmentedLevels.selectedSegmentIndex+1))
        }
    }
}
