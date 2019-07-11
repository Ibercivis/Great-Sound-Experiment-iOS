//
//  Nivel5Controller.swift
//  The-Great-Sound-Experiment-iOS
//
//  Created by Jorge on 18/06/2019.
//  Copyright © 2019 Ibercivis. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class Nivel5Controller: UIViewController {
    
    var player1 = AVAudioPlayer ()
    var player2 = AVAudioPlayer ()
    
    let cantidadAudios: Int = 25
    var sonando1 : Bool = false
    var sonando2 : Bool = false
    var sonando : Int = 0
    var resultado1 : Resultado = Resultado(iniciar: true)
    var readyVotar : Bool = false
    var numeroPartidas : Int = 1
    
    @IBOutlet weak var marcoRespuesta: UIView!
    @IBOutlet weak var audio1: UIButton!
    @IBOutlet weak var audio2: UIButton!
    @IBOutlet weak var respuestaAudio1: UIButton!
    @IBOutlet weak var respuestaAudio2: UIButton!
    @IBOutlet weak var barraNivel: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        marcoRespuesta.layer.cornerRadius = 8
        respuestaAudio1.layer.cornerRadius = 6
        respuestaAudio2.layer.cornerRadius = 6
        resultado1 = generarPares(elnivel: 4)
        
    }
    
    func generarPares(elnivel: Int) -> Resultado {
        
        
        let nivel = elnivel
        let aleatorio: Int = Int(arc4random_uniform(UInt32(cantidadAudios))) + 1
        var nombre: String
        let KEY: String = String(nivel)+String(aleatorio)
        var partida : Partida = Partida(esprueba: true)
        var listaPartidas: [String : Partida] = ["0" : partida]
        var audioGanador = 2
        let partidaFinal : Partida
        sonando1 = false
        sonando2 = false
        sonando = 0
        
        for i in 1...(cantidadAudios+1){
            nombre = String(nivel)+String(i); // Esta es la KEY para sacar parejas del HashMap
            partida = Partida(elnivel: nivel, contador: i)
            listaPartidas[nombre] = partida // Generada una lista de pares de audios de nivel 1.
        }
        
        partidaFinal = listaPartidas[KEY] ?? partida
        
        let name1 = partidaFinal.getAudio1()
        let name2 = partidaFinal.getAudio2()
        //        let path1 = Bundle.main.path(forResource: name1, ofType: ".wav")!
        //        print(path1)
        //        let url1 = URL(fileURLWithPath: path1)
        //        let path2 = Bundle.main.path(forResource: name2, ofType: ".wav")!
        //        print(path2)
        //        let url2 = URL(fileURLWithPath: path2)
        
        
        let aleatorio2 = arc4random_uniform(2)
        
        if (aleatorio2 == 0) {
            //Ordenamos en orden habitual
            if let sound = NSDataAsset(name: name1) {
                do {
                    try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                    try! AVAudioSession.sharedInstance().setActive(true)
                    try player1 = AVAudioPlayer(data: sound.data, fileTypeHint: ".WAV")
                    player1.prepareToPlay()
                    
                } catch {
                    print("error initializing AVAudioPlayer")
                }
                if let sound2 = NSDataAsset(name: name2) {
                    do {
                        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                        try! AVAudioSession.sharedInstance().setActive(true)
                        try player2 = AVAudioPlayer(data: sound2.data, fileTypeHint: ".WAV")
                        player2.prepareToPlay()
                    } catch {
                        print("error initializing AVAudioPlayer")
                    }
                    
                }
                
            }
            audioGanador = 2
            
        } else {
            if let sound = NSDataAsset(name: name1) {
                do {
                    try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                    try! AVAudioSession.sharedInstance().setActive(true)
                    try player2 = AVAudioPlayer(data: sound.data, fileTypeHint: ".WAV")
                    player2.prepareToPlay()
                    
                } catch {
                    print("error initializing AVAudioPlayer")
                }
                if let sound2 = NSDataAsset(name: name2) {
                    do {
                        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                        try! AVAudioSession.sharedInstance().setActive(true)
                        try player1 = AVAudioPlayer(data: sound2.data, fileTypeHint: ".WAV")
                        player1.prepareToPlay()
                    } catch {
                        print("error initializing AVAudioPlayer")
                    }
                    audioGanador = 1
                }
                
                
            }
            
        }
        let resulta = Resultado(laKEY: KEY, elganador: audioGanador)
        return resulta;
    }
    
    func play1(){
        
        sonando1 = true
        
        if(sonando2 == true){
            readyVotar = true
            
        }
        if(player1.isPlaying == false){
            audio1.setImage(UIImage(named: "audio1_on"), for: .normal)
            audio2.setImage(UIImage(named: "audio2_off"), for: .normal)
            player1.play()
            player2.play()
            player1.setVolume(1.0, fadeDuration: 0.0)
            player2.setVolume(0.0, fadeDuration: 0.0)
            sonando = 1
        }
        if(player1.isPlaying == true){
            if(sonando == 1){
                
            }
            if(sonando == 2){
                audio1.setImage(UIImage(named: "audio1_on"), for: .normal)
                audio2.setImage(UIImage(named: "audio2_off"), for: .normal)
                player1.setVolume(1.0, fadeDuration: 0.0)
                player2.setVolume(0.0, fadeDuration: 0.0)
                sonando = 1
            }
        }
    }
    
    func play2(){
        
        sonando2 = true
        
        if(sonando1 == true){
            readyVotar = true
            
        }
        if(player2.isPlaying == false){
            audio2.setImage(UIImage(named: "audio2_on"), for: .normal)
            audio1.setImage(UIImage(named: "audio1_off"), for: .normal)
            player1.play()
            player2.play()
            player2.setVolume(1.0, fadeDuration: 0.0)
            player1.setVolume(0.0, fadeDuration: 0.0)
            sonando = 2
        }
        if(player2.isPlaying == true){
            if(sonando == 2){
                
            }
            if(sonando == 1){
                audio2.setImage(UIImage(named: "audio2_on"), for: .normal)
                audio1.setImage(UIImage(named: "audio1_off"), for: .normal)
                player2.setVolume(1.0, fadeDuration: 0.0)
                player1.setVolume(0.0, fadeDuration: 0.0)
                sonando = 2
            }
        }
    }
    
    @IBAction func lanzarAudio1(_ sender: UIButton) {
        if (sender == audio1) {
            play1()
        }
    }
    @IBAction func lanzarAudio2(_ sender: UIButton) {
        if (sender == audio2) {
            play2()
        }
    }
    @IBAction func votarAudio1(_ sender: UIButton) {
        let resultadoFinal : Int = resultado1.getGanador()
        if (sender == respuestaAudio1){
            if (readyVotar == false){
                self.toastMessage("You have to listen to both audios before you can vote")
            } else {
                if (numeroPartidas == 1) {
                    if (resultadoFinal == 1) {
                        barraNivel.image = UIImage(named: "barranivel2")
                        resultado1 = generarPares(elnivel: 4)
                        readyVotar = false
                        audio2.setImage(UIImage(named: "audio2_off"), for: .normal)
                        audio1.setImage(UIImage(named: "audio1_off"), for: .normal)
                        self.toastMessage("You're right! Keep playing")
                    }
                    else {
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Stats")
                        self.present(newViewController, animated: true, completion: nil)
                        self.toastMessage("Oh no! You have failed")
                    }
                }
                if (numeroPartidas == 2) {
                    if (resultadoFinal == 1) {
                        barraNivel.image = UIImage(named: "barranivel3")
                        resultado1 = generarPares(elnivel: 4)
                        readyVotar = false
                        audio2.setImage(UIImage(named: "audio2_off"), for: .normal)
                        audio1.setImage(UIImage(named: "audio1_off"), for: .normal)
                        self.toastMessage("You're right! Keep playing")
                    }
                    else {
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Stats")
                        self.present(newViewController, animated: true, completion: nil)
                        self.toastMessage("Oh no! You have failed")
                    }
                }
                if (numeroPartidas == 3) {
                    if (resultadoFinal == 1) {
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Stats")
                        self.present(newViewController, animated: true, completion: nil)
                        self.toastMessage("Congratulations! You have overcome the challenge!")
                    }
                    else {
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Stats")
                        self.present(newViewController, animated: true, completion: nil)
                        self.toastMessage("Oh no! You have failed")
                    }
                }
            }
        }
        numeroPartidas = (numeroPartidas + 1)
    }
    @IBAction func votarAudio2(_ sender: UIButton) {
        let resultadoFinal : Int = resultado1.getGanador()
        if (sender == respuestaAudio2){
            if (readyVotar == false){
                self.toastMessage("You have to listen to both audios before you can vote")
            } else {
                if (numeroPartidas == 1) {
                    if (resultadoFinal == 2) {
                        
                        barraNivel.image = UIImage(named: "barranivel2")
                        resultado1 = generarPares(elnivel: 4)
                        readyVotar = false
                        audio2.setImage(UIImage(named: "audio2_off"), for: .normal)
                        audio1.setImage(UIImage(named: "audio1_off"), for: .normal)
                        self.toastMessage("You're right! Keep playing")
                    }
                    else {
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Stats")
                        self.present(newViewController, animated: true, completion: nil)
                        self.toastMessage("Oh no! You have failed")
                    }
                }
                if (numeroPartidas == 2) {
                    if (resultadoFinal == 2) {
                        
                        barraNivel.image = UIImage(named: "barranivel3")
                        resultado1 = generarPares(elnivel: 4)
                        readyVotar = false
                        audio2.setImage(UIImage(named: "audio2_off"), for: .normal)
                        audio1.setImage(UIImage(named: "audio1_off"), for: .normal)
                        self.toastMessage("You're right! Keep playing")
                    }
                    else {
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Stats")
                        self.present(newViewController, animated: true, completion: nil)
                        self.toastMessage("Oh no! You have failed")
                    }
                }
                if (numeroPartidas == 3) {
                    if (resultadoFinal == 2) {
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Stats")
                        self.present(newViewController, animated: true, completion: nil)
                        self.toastMessage("Congratulations! You have overcome the challenge!")
                    }
                    else {
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Stats")
                        self.present(newViewController, animated: true, completion: nil)
                        self.toastMessage("Oh no! You have failed")
                    }
                }
            }
        }
        numeroPartidas = (numeroPartidas + 1)
    }
    
}
