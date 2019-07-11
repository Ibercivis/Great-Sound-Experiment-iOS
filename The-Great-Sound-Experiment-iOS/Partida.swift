//
//  Partida.swift
//  The-Great-Sound-Experiment-iOS
//
//  Created by Jorge on 04/07/2019.
//  Copyright © 2019 Ibercivis. All rights reserved.
//

import Foundation

class Partida {

    var prueba : Bool = false
    var idPartida: String = ""
    var nivel: Int = 0
    var audio1: String = ""
    var audio2: String = ""
    var audioBueno: String = ""
    let cantidadAudios: Int = 25
    
    func setNivel(elnivel: Int){
        self.nivel = elnivel
    }
    
    func setAudio1(elaudio1: String){
        self.audio1 = elaudio1
    }
    
    func setAudio2(elaudio2: String){
        self.audio2 = elaudio2
    }
    
    func getNivel() -> Int {
        return self.nivel
    }
    
    func getAudio1() -> String {
        return self.audio1
    }
    
    func getAudio2() -> String {
        return self.audio2
    }
    
    init(esprueba : Bool) {
        self.prueba = esprueba
    }
    
    init(elnivel: Int, contador: Int) {
        
        let nivel = elnivel
        var level : String
        level = String(nivel)+String(contador)
        self.idPartida = level
        var grupo1: Int
        var grupo2: Int
        
        
        if(nivel==1){
            grupo1 = 2
            grupo2 = 1
            audio1 = "a"+String(grupo1)+String(contador)
            audio2 = "a"+String(grupo2)+String(contador)
            audioBueno = audio2;
        }
        if(nivel==2){
            grupo1 = 0
            grupo2 = 1
            audio1 = "a"+String(grupo1)+String(contador)
            audio2 = "a"+String(grupo2)+String(contador)
            audioBueno = audio2
        }
        if(nivel==3){
            grupo1 = 3
            grupo2 = 1
            audio1 = "a"+String(grupo1)+String(contador)
            audio2 = "a"+String(grupo2)+String(contador)
            audioBueno = audio2;
        }
        if(nivel==4){
            grupo1 = 3
            grupo2 = 4
            audio1 = "a"+String(grupo1)+String(contador)
            audio2 = "a"+String(grupo2)+String(contador)
            audioBueno = audio2
        }
        if(nivel==5){
            grupo1 = 5
            grupo2 = 1
            audio1 = "a"+String(grupo1)+String(contador)
            audio2 = "a"+String(grupo2)+String(contador)
            audioBueno = audio2
        }
        
    }
    
}
