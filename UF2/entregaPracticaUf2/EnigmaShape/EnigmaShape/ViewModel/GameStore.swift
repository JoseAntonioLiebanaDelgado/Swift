//
//  GameStore.swift
//  EnigmaShape
//
//  Created by alumne on 18/03/2024.
//

import Foundation
import AudioToolbox

class GameStore: ObservableObject {
    
    private let baseStringURL = "https://raw.githubusercontent.com/pabloLasalle/db_figuras/main/db.json"
    
    @Published private(set) var puntuacionTotal: Int = 0
    @Published private(set) var numPartida:Int = 1
    @Published private(set) var rondas: [Ronda] = []
    @Published private(set) var haTerminadoLaPartida: Bool = false
    @Published private(set) var error:FetchError?
    @Published private(set) var rondaActual: Ronda?
    
    @Published private(set) var todasLasFiguras = [Figura]()
    
    var sounds: [SoundGame] = [
        SoundGame(name: "rondaganada", type: "mp3"),
        SoundGame(name: "rondaperdida", type: "mp3"),
        SoundGame(name: "siguienteronda", type: "wav")
    ]
    
    init(){
        if (self.todasLasFiguras.isEmpty) {
            loadData()
        }
        setUpSounds()
    }
    func loadData() {
        fetchData{result in
            switch(result){
                case .success(let data):
                    DispatchQueue.main.async {
                        self.todasLasFiguras = data
                        self.crearRondasConFigurasUnicas()
                    }

                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        self.error = error
                    }
            }
        }
    }
    private func fetchData(completion: @escaping(Result<[Figura],FetchError>)->Void) {
        guard let postURL = URL(string: baseStringURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: postURL) { data, response, error in
            if let urlSessionError = error {
                completion(.failure(.urlSessionError(urlSessionError)))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do{
                let datos = try JSONDecoder().decode([Figura].self, from: data)
                completion(.success(datos))
            }catch{
                print(error)
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
    func crearRondasConFigurasUnicas() {
        let figurasMezcladas = self.todasLasFiguras.shuffled() // shuffled() nos permite desordenar un array
        var id = 0
        for figura in figurasMezcladas{
            self.rondas.append(
                Ronda(
                    id: id,
                    figuraRonda: figura,
                    puntuacionRonda: 0,
                    leHaGustadoLaPartida: false,
                    rondaFinalizada: false,
                    numeroRonda: 1
                ))
            id += 1
        }
        
        self.rondaActual = self.rondas[0]
    }
    func checkRonda(rondaActual: Ronda, alturaPuesta: Int, anchuraPuesta: Int) -> Bool {
        let diferenciaAltura = abs(rondaActual.figuraRonda.tamanoFigura.height - alturaPuesta)
        let diferenciaAnchura = abs(rondaActual.figuraRonda.tamanoFigura.width - anchuraPuesta)
        let diferencias = [diferenciaAltura, diferenciaAnchura]
        
        self.rondas[rondaActual.id].rondaFinalizada = true
        
        switch diferencias {
        case let diferencia where diferencia.allSatisfy({$0 == 0}):
            self.puntuacionTotal += 100
            self.rondas[rondaActual.id].puntuacionRonda = 100
            self.rondaActual?.puntuacionRonda = 100
            return true
        case let diferencia where diferencia.allSatisfy({$0 <= 10}):
            self.puntuacionTotal += 80
            self.rondas[rondaActual.id].puntuacionRonda = 80
            self.rondaActual?.puntuacionRonda = 80
            return true
        case let diferencia where diferencia.allSatisfy({$0 <= 20}):
            self.puntuacionTotal += 50
            self.rondas[rondaActual.id].puntuacionRonda = 50
            self.rondaActual?.puntuacionRonda = 50
            return false
        default:
            self.puntuacionTotal += 10
            self.rondas[rondaActual.id].puntuacionRonda = 10
            self.rondaActual?.puntuacionRonda = 10
            return false
        }
    }
    func pasarSiguienteRonda(rondaActual: Ronda) {
        self.rondaActual = self.rondas[rondaActual.id + 1]
        self.rondas[rondaActual.id].numeroRonda = self.numPartida
        for ronda in rondas {
            if (!ronda.rondaFinalizada) {
                self.rondas[ronda.id].numeroRonda = self.numPartida + 1
            }
        }
        self.numPartida += 1
    }
    func resetGame() {
        self.todasLasFiguras = []
        self.rondas = []
        self.puntuacionTotal = 0
        self.numPartida = 1
        self.loadData()
    }
    func actualizarEstadoCorazonRonda(ronda: Ronda, estado: Bool) {
        self.rondas[ronda.id].leHaGustadoLaPartida = estado
    }
    private func setUpSounds(){
        for sound in sounds {
            if let soundURL = Bundle.main.url(forResource: sound.name, withExtension: sound.type) {
                var soundID: SystemSoundID = 0
                AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
            }
        }
    }
    func playSound(name: String) {
        if let sound = sounds.first(where: { $0.name == name }) {
            if let soundURL = Bundle.main.url(forResource: sound.name, withExtension: sound.type) {
                var soundID: SystemSoundID = 0
                AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
                AudioServicesPlaySystemSound(soundID)
            }
        }
    }
}
