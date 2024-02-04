//
//  RickyMortinStore.swift
//  RickyApi
//
//  Created by alumne on 24/01/2024.
//

import Foundation

class RickyMortinStore: ObservableObject{
    
    private let baseStringURL = "https://rickandmortyapi.com/api/character/1,2,3,4,5,6,7,8,9,10"
    
    
    @Published private(set) var rickyMortinsData = [RickyMortin]()
    
    @Published private(set) var error:FetchError?
    
    init(){
        loadData()
    }
    func loadData() {
        fetchData{result in
            switch(result){
                case .success(let arrayRickyMortin):
                    DispatchQueue.main.async {
                        self.rickyMortinsData = arrayRickyMortin
                    }
                    print(self.rickyMortinsData)

                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        self.error = error
                    }
            }
        }
    }
    private func fetchData(completion: @escaping(Result<[RickyMortin],FetchError>)->Void) {
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
                let datos = try JSONDecoder().decode([RickyMortin].self, from: data)
                completion(.success(datos))
            }catch{
                print(error)
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
}
