//
//  FlickrPhotoStore.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

import Foundation

class FlickrPhotoStore: ObservableObject{

    static let api_key = "a4f28588b57387edc18282228da39744"

    static var searchURL = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(api_key)&format=json&nojsoncallback=1&text=nature"
    
    
    @Published private(set) var fotosFlickr = [FlickrPhoto]()
    
    @Published private(set) var error:FetchError?
    
    /*
    init() {
        loadData()
    }
    */
    
    func loadData(searchInputUser: String) {
        FlickrPhotoStore.searchURL = "\(FlickrPhotoStore.searchURL)&text=\(searchInputUser)"
        fetchData{result in
            switch(result){
                case .success(let arrayFotos):
                    DispatchQueue.main.async {
                        self.fotosFlickr = arrayFotos
                        print(self.fotosFlickr)
                    }

                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        self.error = error
                    }
            }
        }
    }
    private func fetchData(completion: @escaping(Result<[FlickrPhoto],FetchError>)->Void) {
        guard let postURL = URL(string: FlickrPhotoStore.searchURL) else {
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
                let datos = try JSONDecoder().decode(FlickrPhotosSearchResponse.self, from: data)
                completion(.success(datos.photos.photo))
            }catch{
                print(error)
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
}
