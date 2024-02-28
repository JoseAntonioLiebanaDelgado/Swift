import UIKit



struct PostElement: Codable {

    let userID, id: Int

    let title, body: String



    enum CodingKeys: String, CodingKey {

        case userID = "userId"

        case id, title, body

    }

}

typealias Post = [PostElement] // Crea un struct de un array de PostElement





enum FetchError:Error{

    case invalidURL

    case urlSessionError(Error)

    case invalidData

    case decodingFailed

}



func fetchData(completion: @escaping(Result<[PostElement],FetchError>)->Void) { // El @escape sirve para indicar que puede devolver un array de PostElements o un FettchError

    // Comprobamos que el URL

    guard let postURL = URL(string:"https://jsonplaceholder.typicode.com/posts") else {

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

        

        // El try? verifica que coincide con la estructura de datos

        do{

            let posts = try JSONDecoder().decode([PostElement].self, from: data)

            completion(.success(posts))

        }catch{

            print(error)

            completion(.failure(.decodingFailed))

        }

    }.resume()

}



fetchData{result in

    switch(result){

        case .success(let arrayT):

            print(arrayT)

        case .failure(let error):

            print(error)

    }

}

