//
//  Resultado.swift
//  The-Great-Sound-Experiment-iOS
//
//  Created by Jorge on 04/07/2019.
//  Copyright © 2019 Ibercivis. All rights reserved.
//

import Foundation

class Resultado {
    
    var iniciado : Bool = false
    var KEY: String = ""
    var ganador: Int = 0
    var UrlAudio1 : URL!
    var UrlAudio2 : URL!
    
    init(iniciar: Bool) {
        self.iniciado = iniciar
    }
    
    init(laKEY: String, elganador: Int) {
        self.ganador = elganador
        self.KEY = laKEY
    }
    
    init(laKEY: String, elganador: Int, url1: URL, url2: URL) {
        self.ganador = elganador
        self.KEY = laKEY
        self.UrlAudio1 = url1
        self.UrlAudio2 = url2
    }
    
    func setKEY(clave: String) {
        self.KEY = clave
    }
    
    func getKEY() -> String {
        return self.KEY
    }
    
    func getGanador() -> Int {
        return self.ganador
    }
    
    func getUrlAudio1() -> URL {
        return self.UrlAudio1
    }
    
    func getUrlAudio2() -> URL {
        return self.UrlAudio2
    }
    
    
}
